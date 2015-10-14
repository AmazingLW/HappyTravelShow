//
//  LoginController.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginSuccessBlock)(BOOL state);

@interface LoginController : UIViewController

@property (nonatomic,copy) LoginSuccessBlock successBlock;//登陆成功后回调

@end
