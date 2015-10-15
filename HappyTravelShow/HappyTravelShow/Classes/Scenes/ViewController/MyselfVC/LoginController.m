//
//  LoginController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface LoginController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *logTableView;
@property(nonatomic,strong)UITextField *userTextField;
@property(nonatomic,strong)UITextField *passwordTextField;

@end

@implementation LoginController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.logTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        self.logTableView.delegate=self;
        self.logTableView.dataSource=self;
        self.logTableView.scrollEnabled=NO;
        [self.view addSubview:self.logTableView];
        
              
        //登陆按钮
        UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame=CGRectMake(20, 290, kWidth-40, 45);
        loginButton.backgroundColor=[UIColor orangeColor];
        [loginButton addTarget:self action:@selector(didClickLoginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.view addSubview:loginButton];
        //找回密码
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-110, 340, 100, 40)];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"找回密码"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        
        label.attributedText = content;
        [self.view addSubview:label];
        //注册
       
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor orangeColor];
        //自定义leftButtonItem
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame=CGRectMake(0, 0, 30, 30);
        [leftButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem=leftButtonItem;

     
    }
    return self;
    
    
}

- (void)backAction{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}





//注册页面跳转

- (void)registerAction{
    
    
    RegisterController *rgVC=[RegisterController new];
    rgVC.isComeLoginPage = YES;
    [self.navigationController pushViewController:rgVC animated:YES];
    
}


//登录事件
- (void)didClickLoginButtonAction{
    //从 LeanCloud服务器查找用户
    [AVUser logInWithUsernameInBackground:self.userTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            //用户存在 并 密码匹配
            NSLog(@"用户登录成功了----%@",[AVUser currentUser]);
            self.successBlock(YES);
            //发出登陆成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucessNotification object:self];
            //退出登陆页面
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            //登陆失败
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertView show];
        }
    }];
  
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //当从注册页面完成注册返回登陆页面时,根据currentUser用户是否为nil,进行登陆成功回调,
    if ([AVUser currentUser]) {
        //发出登陆成功通知
        //登陆成功后回调,同时讲用户信息回传
        self.successBlock(YES);
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucessNotification object:self];
        
        //退出登陆页面
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}





//输入框懒加载
- (UITextField *)userTextField{
    if (_userTextField==nil) {
        
        _userTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
        
    }
    return _userTextField;
}

- (UITextField *)passwordTextField{
    if (_passwordTextField==nil) {
        _passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
    }
    return _passwordTextField;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.logTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //self.view.backgroundColor = [UIColor colorWithWhite:0.28 alpha:0.70];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if (section==1){
      return 0;
    }
 
    return 2;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if (indexPath.section==2&&indexPath.row==0) {
        
        cell.imageView.image=[UIImage imageNamed:@"x.png"];
        self.userTextField.placeholder=@"请输入用户名";
        self.userTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [cell.contentView addSubview:self.userTextField];
        
    }else if (indexPath.section==2&&indexPath.row==1){
    
        cell.imageView.image=[UIImage imageNamed:@"y.png"];
        self.passwordTextField.placeholder=@"请输入密码";
        self.passwordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.passwordTextField.secureTextEntry=YES;
        [cell.contentView addSubview:self.passwordTextField];
    }
    
    
    
    
    return cell;
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 40;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
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
