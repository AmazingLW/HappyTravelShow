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
    self.groundView.image=[UIImage imageNamed:@"backg.jpg"];
    self.groundView.userInteractionEnabled=YES;
    
    self.loginButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame=CGRectMake(kWidth-280, 70, 50, 15);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
       //self.block(self.loginButton);
    
    
    self.registerButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame=CGRectMake(kWidth-155, 70, 50, 15);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.groundView];

    [self.groundView addSubview:self.loginButton];
    [self.groundView addSubview:self.registerButton];
    
}

- (void)loginAction:(UIButton *)button{

    if (self.delegate &&[self.delegate respondsToSelector:@selector(getIntoLoginController:)]) {
        [self.delegate getIntoLoginController:button];
    }

    
    
}



- (void)registerAction{
    
    NSLog(@"注册");
}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
