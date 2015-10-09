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




static BOOL  isOpen = NO;

@interface ComDetailVC ()<UITableViewDelegate,UITableViewDataSource,webViewDelegate>

//保存头部图片的数组
@property (nonatomic,strong) NSMutableArray * picArr;

//保存预定cell 数据的数组
@property (nonatomic,strong) NSMutableArray * bookArr;

//保存详情cell 数据的数组
@property (nonatomic,strong) NSMutableArray * detailArr;

//保存cell变高的高度
@property (nonatomic,assign) CGFloat cellBigHeight;


@end

@implementation ComDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
            DetailModel *detailWeatherModel = weathcerArr[0];
            [cell setWeatherViewWithCityname:model.address date:detailWeatherModel.date temperature:detailWeatherModel.temperature typeDay:detailWeatherModel.weather];
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
        cell.delegate = self;
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

- (void)didClickCell:(NSInteger)index height:(CGFloat)height{
    _cellBigHeight = height;
    if (index == 4) {
        isOpen = !isOpen;
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
        return 80;
    }else if (indexPath.section == 3) {
        return 80;
    }else if (indexPath.section == 4){
        if (isOpen) {
            return _cellBigHeight;
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
