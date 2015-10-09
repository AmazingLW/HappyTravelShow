//
//  FindPlaceVC.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPlaceVC : UIViewController

//经度
@property (nonatomic,assign) CGFloat longitude;

//纬度
@property (nonatomic,assign) CGFloat latitude;

//title
@property (nonatomic,strong) NSString * placeTitle;

//address
@property (nonatomic,strong) NSString * address;

//地区
@property (nonatomic,strong) NSString * cityName;


//天气数组
@property (nonatomic,strong) NSMutableArray * weatherArr;

//是否有天气信息
@property (nonatomic,assign) BOOL isHaveWeatherInfo;


@end
