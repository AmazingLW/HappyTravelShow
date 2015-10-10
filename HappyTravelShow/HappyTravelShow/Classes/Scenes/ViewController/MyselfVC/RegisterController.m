//
//  RegisterController.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "RegisterController.h"
#import "LoginController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface RegisterController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *regisTableView;

@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *messageTextField;
@property(nonatomic,strong)UITextField *passTextField;

@end

@implementation RegisterController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.regisTableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        
        self.regisTableView.delegate=self;
        self.regisTableView.dataSource=self;
        self.regisTableView.scrollEnabled=NO;
        [self.view addSubview:self.regisTableView];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
        
        self.navigationItem.title=@"注册";
        UIButton *regButton=[UIButton buttonWithType:UIButtonTypeCustom];
        regButton.frame=CGRectMake(20, 299, kWidth-40, 45);
        [regButton setTitle:@"免费注册" forState:UIControlStateNormal];
        regButton.backgroundColor=[UIColor orangeColor];
        
        [self.view addSubview:regButton];
        
    }
    return self;
}

//返回登录界面
-(void)loginAction{
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.regisTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 0;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section==1&&indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"x.png"];
        self.phoneTextField.placeholder=@"输入11位手机号码";
        [cell.contentView addSubview:self.phoneTextField];
        
        
    }else if (indexPath.section==1&&indexPath.row==1){
        cell.imageView.image=[UIImage imageNamed:@"zz.png"];
        self.messageTextField.placeholder=@"输入验证码";
        [cell.contentView addSubview:self.messageTextField];
    }else{
        cell.imageView.image=[UIImage imageNamed:@"y.png"];
        self.passTextField.placeholder=@"请输入6-32位数字或字母";
        [cell.contentView addSubview:self.passTextField];
    }
    
    
    
    
    
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

- (UITextField *)phoneTextField{
    
    if (_phoneTextField==nil) {
        
        _phoneTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
    }
    return _phoneTextField;
}

- (UITextField *)messageTextField{
    if (_messageTextField==nil) {
        _messageTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];
    }
    return _messageTextField;
    
}

- (UITextField *)passTextField{
    
    if (_passTextField==nil) {
        
        _passTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 9, kWidth-60, 30)];    }
    
    return _passTextField;
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
