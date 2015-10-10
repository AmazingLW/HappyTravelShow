//
//  MyselfHeadCell.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyselfHeadCell;
@protocol LoginDelegate <NSObject>
- (void)getIntoLoginController:(UIButton *)button ;

@end
//注册代理
@protocol RegisterDelegate <NSObject>

- (void)getIntoRegisterController:(UIButton *)button;

@end



@interface MyselfHeadCell : UITableViewCell
//背景图片
@property(nonatomic,strong) UIImageView   *groundView;
//登陆按钮
@property(nonatomic,strong) UIButton  *loginButton;
//注册按钮
@property(nonatomic,strong) UIButton  *registerButton;
@property(nonatomic,strong) id <LoginDelegate> delegate;
@property(nonatomic,strong) id  <RegisterDelegate> regDelegate;


@end
