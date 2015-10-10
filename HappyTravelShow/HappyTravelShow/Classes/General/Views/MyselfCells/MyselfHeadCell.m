//
//  MyselfHeadCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "MyselfHeadCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width


@implementation MyselfHeadCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self drawView];
    }
    return self;
    
    
}

//绘图

- (void)drawView{
    
    self.groundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 150)];
    self.groundView.image=[UIImage imageNamed:@"my.jpg"];
    self.groundView.userInteractionEnabled=YES;
    
    self.loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame=CGRectMake(kWidth-300, 60, 100, 35);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CALayer *buttonLayer = [self.loginButton layer];
    [buttonLayer setMasksToBounds:YES];
    [buttonLayer setCornerRadius:10];
    [buttonLayer setBorderWidth:1.5];
    [buttonLayer setBorderColor:[[UIColor colorWithWhite:1.00 alpha:1.000] CGColor]];
    
    self.registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.frame=CGRectMake(kWidth-165, 60, 100, 35);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    //设置边框
    CALayer *buttonLayer1 = [self.registerButton layer];
    [buttonLayer1 setMasksToBounds:YES];
    [buttonLayer1 setCornerRadius:10];

    [buttonLayer1 setBorderWidth:1.5];
    [buttonLayer1 setBorderColor:[[UIColor colorWithWhite:1.00 alpha:1.000] CGColor]];
    
    
    [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.groundView];

    [self.groundView addSubview:self.loginButton];
    [self.groundView addSubview:self.registerButton];
    
}

- (void)loginAction:(UIButton *)button{

    if (self.delegate &&[self.delegate respondsToSelector:@selector(getIntoLoginController:)]) {
        [self.delegate getIntoLoginController:button];
    }

    
    
}



- (void)registerAction:(UIButton *)button{
    
    if (self.regDelegate &&[self.regDelegate respondsToSelector:@selector(getIntoRegisterController:)]) {
        [self.regDelegate getIntoRegisterController:button];
    }
    

}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
