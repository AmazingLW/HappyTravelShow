//
//  MyselfVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "MyselfVC.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MyselfHeadCell.h"
#import "MyselfContentCell.h"
#import "LoginController.h"
#import "RegisterController.h"
#import "FavoriteController.h"
#import "browsedController.h"
#import "WeatherDetailController.h"


@interface MyselfVC ()<UITableViewDataSource,UITableViewDelegate,LoginDelegate,RegisterDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)BMKMapView * mapView;

@end

@implementation MyselfVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"myself"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:image tag:1004];
    
        self.tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.view addSubview:self.tableView];
        
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

}



//设置4个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return 2;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0) {
        
        static NSString *const cellIdentifier=@"headerCell";
        MyselfHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        

        if (cell==nil) {
            
            cell=[[MyselfHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.delegate=self;
            cell.regDelegate=self;
        }
        return cell;
    }
    
    static NSString *const cellID=@"contentCell";
        MyselfContentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];

    
        if (cell==nil) {
            cell=[[MyselfContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;

        }
    
    if (indexPath.section == 1 &&indexPath.row==0) {
        cell.label.text=@"我的订单";
        cell.titleView.image=[UIImage imageNamed:@"aa.png"];
    }else if (indexPath.section==2&&indexPath.row==0){
        cell.label.text=@"我的收藏";
        cell.titleView.image=[UIImage imageNamed:@"22.png"];
           }else if (indexPath.section==2&&indexPath.row==1){
        cell.label.text=@"浏览历史";
        cell.titleView.image=[UIImage imageNamed:@"33.png"];
    }else if (indexPath.section==3&&indexPath.row==0){
        cell.label.text=@"分享要出发给朋友";
        cell.titleView.image=[UIImage imageNamed:@"66.png"];
    }else{
        cell.label.text=@"常用设置";
        cell.titleView.image=[UIImage imageNamed:@"55.png"];
        
    }
        

    return cell;
  
    
}

#pragma mark-------代理方法进入登陆界面和注册界面------

- (void)getIntoLoginController:(UIButton *)button{
    LoginController *lgVC=[LoginController new];
    [self.navigationController pushViewController:lgVC animated:YES];

}

- (void)getIntoRegisterController:(UIButton *)button{
    
    RegisterController *rgVC=[RegisterController new];
    
    [self.navigationController pushViewController:rgVC animated:YES];
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 150;
    }
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2&&indexPath.row==0) {
        FavoriteController *fVC=[FavoriteController new];
        [self.navigationController pushViewController:fVC animated:NO];
        

    }else if (indexPath.section==2&&indexPath.row==1)
    {
        
        browsedController *bVC=[browsedController new];
        [self.navigationController pushViewController:bVC animated:NO];
     
        

    }else if (indexPath.section==3&&indexPath.row==1){
        WeatherDetailController *wVC=[WeatherDetailController new];
        [self.navigationController pushViewController:wVC animated:NO];
        
    }
    
}










//-( void)viewWillAppear:(BOOL)animated
//{
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//}

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
