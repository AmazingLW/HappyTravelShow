//
//  ComDetailVC.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ComDetailVC.h"
#import "BookCell.h"
#import "ComDetailHelper.h"
#import "WebViewCell.h"
#import "HeadCell.h"
#import "CommentCell.h"
#import "WeatherCell.h"
#import "DetailModel.h"
#import "DetailIntroduceController.h"
#import "CommomURL.h"
#import "FindPlaceVC.h"
#import "PhotoBrowserVC.h"




static BOOL  isOpen = NO;

@interface ComDetailVC ()<UITableViewDelegate,UITableViewDataSource,webViewDelegate,HeadCellprotocal>

//保存头部图片的数组
@property (nonatomic,strong) NSMutableArray * picArr;

//保存预定cell 数据的数组
@property (nonatomic,strong) NSMutableArray * bookArr;

//保存详情cell 数据的数组
@property (nonatomic,strong) NSMutableArray * detailArr;

//保存cell变高的高度
@property (nonatomic,assign) CGFloat cellBigHeight;

//收藏按钮
@property (nonatomic,strong) UIButton *rightButton;

//收藏状态
@property (nonatomic,assign) BOOL isShoucang;


@end

@implementation ComDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(detailBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
    
    _rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame=CGRectMake(0, 0, 30, 30);
    
    if ([AVUser currentUser] != nil) {
        //先判断数据库表里面有没有
        NSString *sqlQuery = [NSString stringWithFormat:@"select *from Shoucang where detail = '%@' and userID = '%@'",[NSString stringWithFormat:@"%ld",self.detailID],[AVUser currentUser].objectId];
        BOOL isSuc = [[DataBase shareData] selectExistDataFromTable:sqlQuery];
        if (isSuc) {
            //已收藏
            [_rightButton setImage:[UIImage imageNamed:@"shoucanged.png"] forState:UIControlStateNormal];
            _isShoucang = YES;
        }else{
            //未收藏
            [_rightButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
            _isShoucang = NO;
        }
    
    }else{
        [_rightButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
        _isShoucang = NO;
    }
    
    [_rightButton addTarget:self action:@selector(shoucangAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    
    self.navigationItem.rightBarButtonItem=rightButtonItem;

    [self.view addSubview:self.detailTableView];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;

    //请求 预订数据
#warning 更改 此id
//    NSInteger bookID = 67207;
    [[ComDetailHelper new] requestBookData:URL_RequestBookData(self.bookID)type:@"bookData" block:^(NSMutableArray *arr) {
        _bookArr = [NSMutableArray array];
        self.bookArr = arr;
        [self.detailTableView reloadData];
    }];
    
    //请求 详情数据
#warning 更改 此id
//    NSInteger detailID = 11790;
    [[ComDetailHelper new] requestBookData:URL_requestDetailData(self.detailID) type:@"detailData" block:^(NSMutableArray *arr) {
        _detailArr = [NSMutableArray array];
        self.detailArr = arr;
        [self.detailTableView reloadData];
    }];
    
    
}

- (void)detailBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//收藏
- (void)shoucangAction{
    //先判断用户是否登录
    if ([AVUser currentUser] == nil) {
        [self p_showAlertView:@"提示" message:@"请先登录"];
        return;
    }
    
    if (_isShoucang) {
        //已收藏了，现在取消了
        [_rightButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
        
        //从数据库表中删除
        NSString *sqldelete = [NSString stringWithFormat:@"delete from Shoucang where detail = '%@' and userID = '%@'",[NSString stringWithFormat:@"%ld",self.detailID],[AVUser currentUser].objectId];
        BOOL isSuc = [[DataBase shareData] deleteDataFromShoucang:sqldelete];
        if (isSuc) {
            [self p_showAlertView:@"提示" message:@"取消收藏~"];
            _isShoucang = NO;
        }else{
            [self p_showAlertView:@"提示" message:@"取消收藏失败~"];
        }
        
    }else{
        //未收藏，现在收藏了
        [_rightButton setImage:[UIImage imageNamed:@"shoucanged.png"] forState:UIControlStateNormal];
        
        //插入数据库
        //插入数据库表
        if(_detailArr.count != 0){
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            
            
//            NSString *price =  [self numberToString:model.sellPrice];
            
//            NSLog(@"%@",price);
            //获取图片的url
            DetailModel *imgModel = model.imgArr[0];
            NSString *insertSql = [NSString stringWithFormat:@"insert into Shoucang(title,content,curprice,oldprice,sellcount,imgurl,bookID,detail,userID,cictyName)values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model.mainTitle,model.appSubTitle,[self numberToString:model.sellPrice],[self numberToString:model.retailPrice],[self numberToString:model.saledCount],[NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",imgModel.url],model.channelLinkId,model.productId,[AVUser currentUser].objectId,model.cityName];
            
            BOOL isSuc =[[DataBase shareData] insertDataIntoShoucang:insertSql];
            if (isSuc) {
                [self p_showAlertView:@"提示" message:@"收藏成功~"];
                _isShoucang = YES;
            }else{
                [self p_showAlertView:@"提示" message:@"收藏失败~"];
            }

        }
    }
    
}

#pragma mark ------
- (NSString *)numberToString:(NSNumber *)number{
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    
    NSString * s = [numberFormatter stringFromNumber:number];
    return s;
}


//分区个数 ---7个
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 3) {
        return self.bookArr.count;
    }
    return 1;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //头部分区
    if (indexPath.section == 0) {
        static  NSString * const cellIdentifier = @"HeadCell";
        HeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (_detailArr.count != 0) {
            //给cell赋值 图片 title 和内容
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            [cell setHeadViewValue:model.imgArr title:model.appMainTitle strContent:model.appSubTitle];
            cell.delegate = self;
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
 
    }else if (indexPath.section == 1){
        static  NSString * const cellIdentifier = @"CommentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (_detailArr.count != 0) {
            //给cell赋值 图片 title 和内容
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            [cell setCommentCellWithSell:model.saledCount strComment:model.commentCount];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        static  NSString * const cellIdentifier = @"weatherCell";
        WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[WeatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (_detailArr.count != 0) {
            //给cell赋值 图片 title 和内容
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            NSArray *weathcerArr = model.weathcerArr;
            
#warning ---天气信息是空
            if (weathcerArr.count != 0) {
                DetailModel *detailWeatherModel = weathcerArr[0];
                [cell setWeatherViewWithCityname:model.address date:detailWeatherModel.date temperature:detailWeatherModel.temperature typeDay:detailWeatherModel.weather];
            }else{
                [cell setWeatherViewWithCityname:model.address];
            }
            
            
        }
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
 
    }else if (indexPath.section == 3) {
        //预定分区
        static  NSString * const cellIdentifier = @"bookCell";
        BookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[BookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if(_bookArr.count != 0){
            
            BookModel *model = self.bookArr[indexPath.row];
            cell.model = model;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 4){
        static NSString * const cellIdentifier = @"cellWeb";
        WebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[WebViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (_detailArr.count != 0) {
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            [cell setWebViewWithContentStr:model.packageDetial];
            cell.delegate = self;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        static NSString * const cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"xiangqing"];
        cell.textLabel.text = @"详情介绍";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
}

- (void)didClickCell:(NSInteger)index height:(CGFloat)height isopen:(bool)isopen{
    _cellBigHeight = height;
    if (index == 4) {
        isOpen = isopen;
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
        [self.detailTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 210;
    }else if (indexPath.section == 1){
        return 40;
    }else if (indexPath.section == 2){
        if (_detailArr.count != 0) {
            //给cell赋值 图片 title 和内容
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            NSArray *weathcerArr = model.weathcerArr;
            if (weathcerArr.count == 0) {
                return 40;
            }
        }
        return 80;
    }else if (indexPath.section == 3) {
        return 80;
    }else if (indexPath.section == 4){
        if (isOpen) {
            return _cellBigHeight + 10;
        }else{
            return 80;
        }
        
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 1;
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 5) {
        DetailIntroduceController *detailVC = [DetailIntroduceController new];
        
        if (_detailArr.count != 0) {
            DetailModel *model = (DetailModel *)_detailArr.firstObject;
            detailVC.htmlData = model.productIntroduction;
        }
        
        UINavigationController *detailNV = [[UINavigationController alloc] initWithRootViewController:detailVC];
        [self presentViewController:detailNV animated:YES completion:nil];
    }else if (indexPath.section == 2) {
        FindPlaceVC *findVC = [FindPlaceVC new];
        findVC.isHaveWeatherInfo = NO;
        DetailModel *model = (DetailModel *)_detailArr.firstObject;
        findVC.address = model.address;
        findVC.placeTitle = model.productName;
        findVC.longitude = [model.longitude floatValue];
        findVC.latitude = [model.latitude floatValue];
        findVC.cityName = model.cityName;
        if (model.weathcerArr.count != 0) {
            //数组里面有天气信息
            findVC.weatherArr = [model.weathcerArr mutableCopy];
            findVC.isHaveWeatherInfo = YES;
        }
        
        [self.navigationController pushViewController:findVC animated:YES];
    }
}


#pragma mark ----lazy load----

- (UITableView *)detailTableView{
    if (_detailTableView == nil) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _detailTableView.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _detailTableView;
}

- (NSMutableArray *)picArr{
    if (_picArr == nil) {
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}

- (NSMutableArray *)bookArr{
    if (_bookArr == nil) {
        _bookArr = [NSMutableArray array];
    }
    return _bookArr;
}


#pragma mark ----轮播图页面跳转代理方法----

- (void)jumpPhotoVCWithPhotoArr:(NSArray *)imgviewArr index:(NSInteger)photoIndex{
    PhotoBrowserVC *photoVC = [PhotoBrowserVC new];
    DetailModel *model = (DetailModel *)_detailArr.firstObject;
    photoVC.photoInfoArr = model.imgArr;
    photoVC.strMain = model.productName;
    photoVC.pageIndex = photoIndex;
#warning -----页面跳转有点慢
    photoVC.imgArr = [NSKeyedUnarchiver unarchiveObjectWithData: [NSKeyedArchiver archivedDataWithRootObject:imgviewArr]];
    
    UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:photoVC];
    
    [self presentViewController:rootNC animated:YES completion:nil];
}



















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
