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
#import "ChangePersonInfoVC.h"
#import "FinderKindModel.h"


@interface MyselfVC ()<UITableViewDataSource,UITableViewDelegate,LoginDelegate,RegisterDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)BMKMapView * mapView;

@property (nonatomic,assign) BOOL isLoginState;

@property (nonatomic,assign) BOOL isgetUserInfoState;

@property(nonatomic,strong) FinderKindModel  *kindModel;

@property (nonatomic,strong) NSString *path;

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
    self.title = @"我的";

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
        //获取缓存数据
        cell.label.text = @"清除缓存";
        _path = [self CachesDirectory];
        double cacheSize = [self sizeWithFilePath:_path];
        cell.cacheLabel.text = [NSString stringWithFormat:@"%0.2lfKB",cacheSize];
        cell.cacheLabel.textAlignment = NSTextAlignmentRight;
        cell.cacheLabel.textColor = [UIColor orangeColor];
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
        cell.label.text=@"退出登录";
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
        //清除缓存
        UIAlertView *altertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"清除缓存将会降低页面加载速度,你确定继续么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清理",nil];
        altertView.tag = 1001;
        [altertView show];
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
        //浏览历史记录
        browsedController *bVC=[browsedController new];
        bVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bVC animated:YES];
        bVC.hidesBottomBarWhenPushed = YES;
        
    }else if (indexPath.section==3&&indexPath.row==0){
        NSLog(@"分享我们的App");
    }else if (indexPath.section==3&&indexPath.row==1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出此账号么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1002;
        [alertView show];
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 1002) {
            //用户注销，修改登陆状态
            [AVUser logOut];  //清除缓存用户对象  现在的currentUser是nil了
            _isLoginState = NO;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [self clearCachesWithFilePath:_path];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}



#pragma mark ---清除缓存---
// 按路径清除文件
- (void)clearCachesWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
    
}


- (double)sizeWithFilePath:(NSString *)path
{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1000 * 1000.0);
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1000 * 1000.0);
    }
}

- (NSString *)CachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
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
