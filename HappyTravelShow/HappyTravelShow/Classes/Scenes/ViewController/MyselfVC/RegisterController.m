//
//  RegisterController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "RegisterController.h"
#import "LoginController.h"
#import "NSString+Check.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface RegisterController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *regisTableView;

@property (nonatomic,strong) UITextField * usernameTextField;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *passConfirmTextField;
@property(nonatomic,strong)UITextField *passTextField;

@property (nonatomic,strong) UIButton * checkBtn;


@property (nonatomic,strong) NSString * codeStr;

@end

@implementation RegisterController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.regisTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        
        self.regisTableView.delegate=self;
        self.regisTableView.dataSource=self;
        self.regisTableView.scrollEnabled=NO;
        [self.view addSubview:self.regisTableView];
        
        self.navigationItem.title=@"注册";
        UIButton *regButton=[UIButton buttonWithType:UIButtonTypeCustom];
        regButton.frame=CGRectMake(20, 299, kWidth-40, 45);
        [regButton setTitle:@"免费注册" forState:UIControlStateNormal];
        regButton.backgroundColor=[UIColor orangeColor];
        
        [regButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:regButton];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.regisTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"x.png"];
        self.usernameTextField.placeholder=@"请输入用户名";
        [cell.contentView addSubview:self.usernameTextField];
    }else if (indexPath.row==1){
        cell.imageView.image=[UIImage imageNamed:@"y.png"];
        self.passTextField.placeholder=@"请输入6-32位数字或字母";
        self.passTextField.secureTextEntry=YES;
        [cell.contentView addSubview:self.passTextField];
    }else if (indexPath.row==2){
        cell.imageView.image=[UIImage imageNamed:@"y.png"];
        self.passConfirmTextField.placeholder=@"请再次输入密码";
        self.passConfirmTextField.secureTextEntry=YES;
        [cell.contentView addSubview:self.passConfirmTextField];
    }else{
        cell.imageView.image=[UIImage imageNamed:@"regPhone.png"];
        self.phoneTextField.placeholder=@"请输入电话号";
        [cell.contentView addSubview:self.phoneTextField];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

- (UITextField *)phoneTextField{
    
    if (_phoneTextField==nil) {
        
        _phoneTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.tag = 1001;
        [_phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _phoneTextField;
}

- (UITextField *)usernameTextField{
    
    if (_usernameTextField==nil) {
        _usernameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
        
    }
    return _usernameTextField;
}



- (UITextField *)passConfirmTextField{
    if (_passConfirmTextField==nil) {
        _passConfirmTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
    }
    return _passConfirmTextField;
    
}

- (UITextField *)passTextField{
    
    if (_passTextField==nil) {
        
        _passTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];    }
    
    return _passTextField;
}


//- (UIButton *)checkBtn{
//    if (_checkBtn == nil) {
//        _checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        _checkBtn.frame = CGRectMake(kScreenWidth - 73, 7, 70, 30);
//        [_checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        _checkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_checkBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_checkBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
//        [_checkBtn addTarget:self action:@selector(isPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _checkBtn;
//}




#pragma mark ------获取短信验证码--------
- (BOOL)isPhoneNumber{
    
    if (_phoneTextField.text.length == 0) {
        [self p_showAlertView:@"提示" message:@"请输入手机号码"];
        return NO;
    }
    
    if (_phoneTextField.text.length != 11) {
        [self p_showAlertView:@"提示" message:@"请输入11位手机号码"];
        return NO;
    }
    
    if (![_phoneTextField.text checkPhoneNumInput]) {
        [self p_showAlertView:@"提示" message:@"请输入正确的手机号码"];
        return NO;
    }
    return YES;
}

#pragma mark -------判断textfield长度------
 - (void)textFieldDidChange:(UITextField *)textField{
//     NSLog(@"%ld",textField.text.length);
 }


#pragma mark ------textfield 代理方法-----------




#pragma mark ----注册按钮实现------

- (void)registerAction{
    
    //判断是否输入了用户名
    if (_usernameTextField.text.length == 0) {
        [self p_showAlertView:@"提示" message:@"请输入用户名"];
        return;
    }
    
    //判断手机号是否输入正确
    if (![self isPhoneNumber]) {
        return;
    }

    //注册时，两次输入的密码必须一致
    NSString *pwd1 = _passTextField.text;
    NSString *pwd2 = _passConfirmTextField.text;
    if (NO == [pwd1 isEqualToString:pwd2]) {
        [self p_showAlertView:@"提示" message:@"两次输入的密码不一致"];
        return;
    }
    
    //注册用户
    AVUser *user = [AVUser user];
    user.username = _usernameTextField.text;
    user.password =  _passTextField.text;
    user.mobilePhoneNumber = _phoneTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //注册完成后,直接登录并且返回个人主页
            NSLog(@"注册成功");
            
            if (!_isComeLoginPage) {
                self.block(YES);
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            //注册失败
            self.codeStr = [self errorCode:error.code];
            [self p_showAlertView:@"提示" message:self.codeStr];
        }
    }];
    
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
