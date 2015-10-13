//
//  RegisterController.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^regBlOCK)(BOOL state);

@interface RegisterController : UIViewController

@property (nonatomic,copy) regBlOCK block;

@property (nonatomic,assign) BOOL isComeLoginPage;

@end
