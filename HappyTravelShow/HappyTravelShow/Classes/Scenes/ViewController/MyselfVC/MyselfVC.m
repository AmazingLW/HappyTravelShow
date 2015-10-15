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
#import "ChangePersonInfoVC.h"
#import "FinderKindModel.h"


@interface MyselfVC ()<UITableViewDataSource,UITableViewDelegate,LoginDelegate,RegisterDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)BMKMapView * mapView;

@property (nonatomic,assign) BOOL isLoginState;

@property (nonatomic,assign) BOOL isgetUserInfoState;

@property(nonatomic,strong) FinderKindModel  *kindModel;

@end

@implementation MyselfVC

- (void)dealloc{
    //注销----登陆成功的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSucessNotification object:nil];
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"myself"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:image tag:1004];
    
        self.tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.view addSubview:self.tableView];
        
        
        //注册----登陆成功的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginSuccessNotification:) name:kLoginSucessNotification object:nil];
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  

}

//当接收登陆成功消息 或者修改信息的消息后执行
- (void)handleLoginSuccessNotification:(NSNotification *)notification{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isgetUserInfoState = NO;
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


-( void)viewWillAppear:(BOOL)animated
{
    if ([AVUser currentUser]) {
        _isLoginState = YES;
    }else{
        _isLoginState = NO;
    }
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
        
        
        if (self.isLoginState) {
            [cell drawAgainWithUsername:[AVUser currentUser].username phone:[AVUser currentUser].mobilePhoneNumber];
        }else{
            [cell drawView];
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
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
  
    
}

#pragma mark-------代理方法进入登陆界面和注册界面------

- (void)getIntoLoginController:(UIButton *)button{
    LoginController *lgVC=[LoginController new];
    lgVC.successBlock = ^(BOOL state){
        self.isLoginState = YES;
    };
    
    [self.navigationController pushViewController:lgVC animated:YES];

}

- (void)getIntoRegisterController:(UIButton *)button{
    
    RegisterController *rgVC=[RegisterController new];
    
    rgVC.block = ^(BOOL state){
        self.isLoginState = state;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    [self.navigationController pushViewController:rgVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 150;
    }
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (_isLoginState && _isgetUserInfoState == NO) {
            _isgetUserInfoState = YES;
            ChangePersonInfoVC *changeVC = [ChangePersonInfoVC new];
            
            //请求个人信息
            AVQuery *query = [AVUser query];
            [query whereKey:@"username" equalTo:[AVUser currentUser].username];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error == nil) {
                    NSDictionary *d = objects.firstObject;
                    changeVC.tel = d[@"mobilePhoneNumber"];
                    changeVC.name = d[@"username"];
                    changeVC.email = d[@"email"];
                    changeVC.gender = d[@"gender"];
                    changeVC.birth = d[@"brithday"];
                    changeVC.address = d[@"address"];
                    changeVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:changeVC animated:YES];
                    changeVC.hidesBottomBarWhenPushed = YES;
                } else {
                    NSLog(@"查无此人");
                }
            }];
        }else{
            NSLog(@"nothing");
        }
    }else if (indexPath.section == 1 &&indexPath.row==0){
        
//        BOOL isSuc = [[DataBase shareData] deleteTable:@"Shoucang"];
//        if (isSuc) {
//            [self p_showAlertView:@"提示" message:@"已清空"];
//        }
        
    }else if (indexPath.section==2&&indexPath.row==0) {
        
        //收藏页
        
        //判断用户是否登录
        if ([AVUser currentUser] == nil) {
            [self p_showAlertView:@"提示" message:@"请先登录"];
            return;
        }

        FavoriteController *fVC=[FavoriteController new];
//        fVC.shouCangArr = [shoucangArr mutableCopy];
        fVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fVC animated:YES];
        fVC.hidesBottomBarWhenPushed = YES;

    }else if (indexPath.section==2&&indexPath.row==1)
    {
        browsedController *bVC=[browsedController new];
        bVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bVC animated:YES];
        bVC.hidesBottomBarWhenPushed = YES;
        
    }else if (indexPath.section==3&&indexPath.row==0){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
        [AVUser logOut];  //清除缓存用户对象
    }else if (indexPath.section==3&&indexPath.row==1){
        WeatherDetailController *wVC=[WeatherDetailController new];
        [self.navigationController pushViewController:wVC animated:NO];
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //用户注销，修改登陆状态
        [AVUser logOut];  //清除缓存用户对象  现在的currentUser是nil了
        _isLoginState = NO;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}







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
