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


@interface ScenicDetailVC ()<UITableViewDelegate,UITableViewDataSource,openScrollProtocal>
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

}

- (void)requestData{

    [[ComDetailHelper new] requestBookData:URL_ScenicDetail(self.scenicID) type:@"scenidDetailData" block:^(NSMutableArray *arr) {
        self.scenicArr = arr;
        [self.tableView reloadData];
    }];
    
    [[ComDetailHelper new] requestBookData:URL_ticketData(self.scenicID) type:@"ticketDetailData" block:^(NSMutableArray *arr) {
        self.ticketArr = arr;
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
        }
        
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
            }else if (indexPath.row == 1){
                //[cell setViewWithIndex:indexPath.row strDetail:<#(NSString *)#>]
            }else{
                [cell setViewWithIndex:indexPath.row strDetail:model.openTime];
            }
        }
        
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
        
        return cell;
        
    }else if (indexPath.section == 3){
        static NSString * cellIdentifier = @"introduceCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"aa"];
        cell.textLabel.text = @"景区介绍";
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
