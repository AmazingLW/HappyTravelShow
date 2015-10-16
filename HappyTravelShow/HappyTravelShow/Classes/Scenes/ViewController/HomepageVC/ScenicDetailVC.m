//
//  ScenicDetailVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ScenicDetailVC.h"
#import "SDHeaderCell.h"
#import "PlaceTempTimeCell.h"
#import "MealDetailCell.h"
#import "MealTicketCell.h"
#import "ComDetailHelper.h"
#import "HomepageURL.h"
#import "ScenicDetailModel.h"
#import "DetailplaceMapVC.h"
#import "WeatherDetailController.h"
#import "SkyModel.h"
#import "ComDetailVC.h"
#import "UMSocial.h"


@interface ScenicDetailVC ()<UITableViewDelegate,UITableViewDataSource,openScrollProtocal,BackandShareProtocal,UMSocialUIDelegate>
{
    UIView *_backView;
}
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UITableView * mealTableView;
@property (nonatomic,strong) UITableView * ticketTableView;

@property (nonatomic,strong) UIButton *packageBtn;
@property (nonatomic,strong) UIButton *ticketBtn;
@property (nonatomic,strong) UIView *colorView;

//接收具体景区信息的数组
@property (nonatomic,strong) NSMutableArray * scenicArr;

//接收门票信息的数组
@property (nonatomic,strong) NSMutableArray * ticketArr;

//接收天气信息的数组
@property (nonatomic,strong) NSMutableArray * skyArr;


@end

@implementation ScenicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 701;
    self.tableView.bounces = NO; //禁止反弹
    [self.view addSubview:self.tableView];
    //请求数据
    [self requestData];
    
    //自定义leftBarButtonItem
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame=CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem=leftButtonItem;

}

- (void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)requestData{

    [[ComDetailHelper new] requestBookData:URL_ScenicDetail(self.scenicID) type:@"scenidDetailData" block:^(NSMutableArray *arr) {
        self.scenicArr = arr;
        [self.tableView reloadData];
    }];
    
#warning  ---- 需要传itemid
    [[ComDetailHelper new] requestBookData:URL_ticketData(self.scenicID) type:@"ticketDetailData" block:^(NSMutableArray *arr) {
        self.ticketArr = arr;
        [self.tableView reloadData];
    }];
    
    NSString *str = [@"北京" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[ComDetailHelper new] requestBookData:URL_sky(str) type:@"cityWeatherData" block:^(NSMutableArray *arr) {
        self.skyArr = arr;
        [self.tableView reloadData];
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}


//返回row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1){
        return 50;
    }else if (indexPath.section == 2){
        return 230;
    }else if (indexPath.section == 3){
        return 50;
    }else{
        return kScreenHeight - 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _packageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _packageBtn.frame = CGRectMake(0, 0, kScreenWidth/2, 48);
        [_packageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_packageBtn setTitle:@"套餐" forState:UIControlStateNormal];
        [_packageBtn addTarget:self action:@selector(packageAction) forControlEvents:UIControlEventTouchUpInside];
        [_packageBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _ticketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ticketBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 48);
        [_ticketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_ticketBtn setTitle:@"门票" forState:UIControlStateNormal];
        [_ticketBtn addTarget:self action:@selector(ticketBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        //变色的view
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(47, 48, 100, 2)];
        _colorView.backgroundColor = [UIColor orangeColor];
        
        [headView addSubview:_packageBtn];
        [headView addSubview:_ticketBtn];
        [headView addSubview:_colorView];
        return headView;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 4) {
        return 50;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        return 12;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString * cellIdentifier = @"headerCell";
        SDHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[SDHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if(self.scenicArr.count != 0){
            ScenicDetailModel *model = self.scenicArr.firstObject;
            [cell setViewWithTitle:model.scenicName coverPic:model.coverPic];
            cell.shareBlock = ^(){
                //分享
               // NSLog(@"分享====");
                
                
                //图片
                [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:model.coverPic];
                
                  //链接
                NSString *url=[NSString stringWithFormat:@"http://http://www.yaochufa.com/scenic/info/%ld",self.scenicID];
                
                
                    [UMSocialSnsService presentSnsIconSheetView:self
                                                                 appKey:@"561dd14067e58e135400590f"
                                                              shareText:[NSString stringWithFormat:@"这个地方不错哦,%@,%@",model.scenicName,url]
                                                             shareImage:nil
                                                        shareToSnsNames:[NSArray arrayWithObjects:  UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToDouban,UMShareToEmail, nil ]
                                                               delegate:self];
              
                
            };

            
        }
        cell.delegate = self;
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        static NSString * cellIdentifier = @"placeTempCell";
        PlaceTempTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[PlaceTempTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (self.scenicArr.count != 0) {
           ScenicDetailModel *model = self.scenicArr.firstObject;
            if (indexPath.row == 0) {
                [cell setViewWithIndex:indexPath.row strDetail:model.address];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            }else if (indexPath.row == 1 && self.skyArr.count != 0){
                SkyModel *model = self.skyArr[0];
                SkyModel *skyModel = model.skyArr[0];
                [cell setViewWithObject:skyModel];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            }else{
                [cell setViewWithIndex:indexPath.row strDetail:model.openTime];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 2){
        static NSString * cellIdentifier = @"baokuanCell";
        MealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MealDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (self.scenicArr.count != 0) {
            ScenicDetailModel *model = self.scenicArr.firstObject;
            ScenicDetailModel *baokuanModel = model.baokuanArr.firstObject;
            [cell setViewWithModel:baokuanModel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 3){
        static NSString * cellIdentifier = @"introduceCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"aa"];
        cell.textLabel.text = @"景区介绍";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        static NSString * cellIdentifier = @"ticketCell";
        MealTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MealTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        if (self.scenicArr.count != 0) {
            ScenicDetailModel *model = self.scenicArr.firstObject;
            cell.mealTicketArr = [model.mealMuaArr mutableCopy];
            cell.ticketArr = [self.ticketArr mutableCopy];
        }
        
        cell.block = ^(NSString *strType){
            if ([strType isEqualToString:@"left"]) {
                [self packageAction];
            }else{
                [self ticketBtnAction];
            }
        };
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//点击分享后的代理方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
    }else{
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"分享失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alertView show];
    }
    
}








#pragma mark ----点击cell跳转-----
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //地图页
            DetailplaceMapVC * detailVC = [DetailplaceMapVC new];
            ScenicDetailModel *model = self.scenicArr.firstObject;
            detailVC.longitude = [model.longitude floatValue];
            detailVC.latitude = [model.latitude floatValue];
            detailVC.placeTitle = model.address;
            detailVC.vcTitle = model.scenicName;
            UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:detailVC];
            
            [self presentViewController:rootNC animated:YES completion:nil];
        }else if (indexPath.row == 1){
            WeatherDetailController *weatherVC = [WeatherDetailController new];
            UINavigationController *rootNC = [[UINavigationController alloc] initWithRootViewController:weatherVC];
            weatherVC.skyArr = self.skyArr;
            [self presentViewController:rootNC animated:YES completion:nil];
        }
        
    }else if (indexPath.section == 2){
        ScenicDetailModel *model = self.scenicArr.firstObject;
        ScenicDetailModel *baokuanModel = model.baokuanArr.firstObject;
        
#warning 少linkid-----
        
//        NSInteger productld=[self.RecommendationArr[indexPath.row] productId];
//        NSInteger nlinkId=[self.RecommendationArr[indexPath.row] channelLinkId];
        
        ComDetailVC * detailVC = [ComDetailVC new];
        detailVC.bookID = [baokuanModel.productId integerValue];
        detailVC.detailID = [baokuanModel.productId integerValue];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        detailVC.hidesBottomBarWhenPushed = YES;
    }
}



- (void)packageAction{
    [_packageBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_ticketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        _colorView.frame = CGRectMake(47, 48, 100, 2);
    }];
    
    //scrollView滚动
    MealTicketCell *cell = (MealTicketCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    UIScrollView *scrollView = (UIScrollView *)[cell viewWithTag:601];
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 0);
    }];

    
}

- (void)ticketBtnAction{
    [_ticketBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_packageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        _colorView.frame = CGRectMake(kScreenWidth - 140, 48, 100, 2);
    }];
    
    //scrollView滚动
    MealTicketCell *cell = (MealTicketCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    UIScrollView *scrollView = (UIScrollView *)[cell viewWithTag:601];
    
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    }];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 650) {
        scrollView.scrollEnabled = NO;
        MealTicketCell *cell = (MealTicketCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
        UITableView *tableMealView = (UITableView *)[cell viewWithTag:501];
        UITableView *tableTicketView = (UITableView *)[cell viewWithTag:502];
        tableMealView.scrollEnabled = YES;
        tableTicketView.scrollEnabled = YES;
        
    }
}

- (void)openScrollEnable{
    self.tableView.scrollEnabled = YES;
}


#pragma mark ---懒加载----

- (NSMutableArray *)scenicArr{
    if (_scenicArr == nil) {
        _scenicArr = [NSMutableArray array];
    }
    return _scenicArr;
}

- (NSMutableArray *)ticketArr{
    if (_ticketArr == nil) {
        _ticketArr = [NSMutableArray array];
    }
    return _ticketArr;
}

- (NSMutableArray *)skyArr{
    if (_skyArr == nil) {
        _skyArr = [NSMutableArray array];
    }
    return _skyArr;
}

- (void)backToHomepage{
    [self dismissViewControllerAnimated:YES completion:nil];
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
