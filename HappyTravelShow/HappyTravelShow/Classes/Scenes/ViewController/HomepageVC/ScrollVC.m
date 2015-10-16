



//
//  ScrollVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ScrollVC.h"
#import "FinderKindModel.h"
#include "FinderHelper.h"
#import "CommonCells.h"
#import "FindMainDetaiCell.h"
#import "ComDetailVC.h"
#import "UMSocial.h"
#import "FinderURL.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "FinderHelper.h"
@interface ScrollVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *uiTableView;
@property(nonatomic,strong) NSMutableArray  *kindArray;
@end

@implementation ScrollVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.uiTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.view addSubview:self.uiTableView];
        self.uiTableView.delegate=self;
        self.uiTableView.dataSource=self;
        

        
        //自定义leftBarButtonItem
        
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame=CGRectMake(0, 0, 30, 30);
        [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem=leftButtonItem;
    
    }
    return self;
    
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //自定义title颜色
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.text=self.model.title;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
//    [[FinderHelper sharedHelper]requestDataWithThemeId:self.cityCode cityCode:self.cityNum pageIndex:@"1" Finish:^{
//        [self.uiTableView reloadData];
//        
//    }];
    
    [[FinderHelper sharedHelper]requestDataWithPageSize:10 ThemeId:self.cityCode cityCode:self.cityNum pageIndex:1 Finish:^(NSMutableArray *arr) {
        self.kindArray=[NSMutableArray array];
        self.kindArray=[arr mutableCopy];
        
        [self.uiTableView reloadData];
        
        
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.uiTableView registerNib:[UINib nibWithNibName:@"CommonCells" bundle:nil] forCellReuseIdentifier:@"commonCell"];
    
}




//设两个分区

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    return _kindArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    CommonCells *cell=[self.uiTableView dequeueReusableCellWithIdentifier:@"commonCell" forIndexPath:indexPath];
    
    cell.kindModel=self.kindArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 100;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ComDetailVC *comVC = [ComDetailVC new];
  
        

    //获取model对象
    FinderKindModel *model = self. kindArray[indexPath.row];
    comVC.bookID = [model.channelLinkId intValue];
    comVC.detailID = [model.productId intValue];
    [self.navigationController pushViewController:comVC animated:YES];
    
    
}


- (void)backAction{
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
