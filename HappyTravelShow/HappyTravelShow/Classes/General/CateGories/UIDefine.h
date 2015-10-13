//
//  UIDefine.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)p_showAlertView:(NSString *)title message:(NSString *)message;

- (NSString *)errorCode:(NSInteger)code;

@end