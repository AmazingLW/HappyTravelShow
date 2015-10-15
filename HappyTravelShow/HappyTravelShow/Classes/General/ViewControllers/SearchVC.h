//
//  SearchVC.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^BLOCK)(NSString *);

@protocol PassWordDelegate <NSObject>

- (void)passwordWithString:(NSString *)string;

@end

@interface SearchVC : UIViewController

@property (nonatomic, assign)id<PassWordDelegate>delegate;

//传值
@property (nonatomic, copy)BLOCK block;

@end
