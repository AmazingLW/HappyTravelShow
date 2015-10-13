//
//  DetailplaceMapVC.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailplaceMapVC : UIViewController

//经度
@property (nonatomic,assign) CGFloat longitude;

//纬度
@property (nonatomic,assign) CGFloat latitude;

//title
@property (nonatomic,strong) NSString * placeTitle;

//标题
@property (nonatomic,strong) NSString * vcTitle;

@end
