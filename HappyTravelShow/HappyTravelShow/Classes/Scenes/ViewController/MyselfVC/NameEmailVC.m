//
//  NameEmailVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "NameEmailVC.h"

@interface NameEmailVC ()

@property (nonatomic,strong) UITextField * nameTF;
@property (nonatomic,strong) UITextField * emailTF;

@end

@implementation NameEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isChangeName) {
        self.title = @"修改姓名";
    }else{
        self.title = @"修改邮箱";
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self drawView];
    
}

- (void)drawView{
 
    //
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 74, kScreenWidth, 50)];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    [view1 addSubview:titleLabel];
    if (_isChangeName) {
        titleLabel.text = @"姓  名:";
        self.nameTF.text = self.name;
        [view1 addSubview:self.nameTF];
    }else{
        titleLabel.text = @"邮  箱:";
        self.emailTF.text = self.email;
        [view1 addSubview:self.emailTF];
    }
    //
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 135)];

    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kScreenWidth, 80)];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor lightGrayColor];
    if (_isChangeName) {
        contentLabel.text = @"限定中文或者英文,不少于4个字符,不能多于10个字符";
    }else{
        contentLabel.text = @"请输入您的常用的邮箱地址";
    }
    
    
    //保存按钮
    UIButton *saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame=CGRectMake(20, 92, kScreenWidth - 40, 45);
    saveButton.backgroundColor=[UIColor orangeColor];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:saveButton];
    [backView addSubview:contentLabel];
    //    backView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view1];
    [self.view addSubview: backView];
    
    
    
}

- (void)saveButtonAction{
    if (_isChangeName) {
        
        // 知道 objectId，创建 AVObject
        AVObject *post = [AVObject objectWithoutDataWithClassName:@"_User" objectId:[AVUser currentUser].objectId];
        //更新属性
        [post setObject:self.nameTF.text forKey:@"username"];
        //保存
        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [[AVUser currentUser] setUsername:self.nameTF.text];
                [[AVUser currentUser] saveInBackground];
                
                self.changeBlock(self.nameTF.text);
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucessNotification object:self];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self p_showAlertView:@"提示" message:[self errorCode:error.code]];
            }
        }];
        
        
    }else{
        // 知道 objectId，创建 AVObject
        AVObject *post = [AVObject objectWithoutDataWithClassName:@"_User" objectId:[AVUser currentUser].objectId];
        //更新属性
        [post setObject:self.emailTF.text forKey:@"email"];
        //保存
        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [[AVUser currentUser] setEmail:self.emailTF.text];
                [[AVUser currentUser] saveInBackground];
                
                self.changeBlock(self.emailTF.text);
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self p_showAlertView:@"提示" message:[self errorCode:error.code]];
            }
        }];

    }
}


- (UITextField *)nameTF{
    if (_nameTF == nil) {
        _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(78, 0, kScreenWidth - 90, 50)];
    }
    return _nameTF;
}

- (UITextField *)emailTF{
    if (_emailTF == nil) {
        _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(78, 0, kScreenWidth - 90, 50)];
    }
    return _emailTF;
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
