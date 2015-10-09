//
//  LoginController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "LoginController.h"
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
        loginButton.frame=CGRectMake(20, 310, kWidth-40, 50);
        loginButton.backgroundColor=[UIColor orangeColor];
        
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.view addSubview:loginButton];
        //找回密码
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-120, 380, 1000, 40)];
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"找回密码"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        
        label.attributedText = content;
        [self.view addSubview:label];

        
    }
    return self;
    
    
}
//输入框懒加载
- (UITextField *)userTextField{
    if (_userTextField==nil) {
        
        _userTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 11, kWidth-60, 40)];
        
    }
    return _userTextField;
}

- (UITextField *)passwordTextField{
    if (_passwordTextField==nil) {
        _passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 11, kWidth-60, 40)];
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
        
        cell.imageView.image=[UIImage imageNamed:@"user.png"];
        self.userTextField.placeholder=@"请输入用户名";
        self.userTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [cell.contentView addSubview:self.userTextField];
        
    }else if (indexPath.section==2&&indexPath.row==1){
    
        cell.imageView.image=[UIImage imageNamed:@"password.png"];
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
    
    return 53;
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
