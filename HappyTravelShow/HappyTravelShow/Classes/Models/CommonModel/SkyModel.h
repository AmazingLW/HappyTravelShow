//
//  SkyModel.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkyModel : NSObject

//currentCity
@property (nonatomic,strong) NSString * currentCity;

//date
@property (nonatomic,strong) NSString * date;

//dayPictureUrl
@property (nonatomic,strong) NSString * dayPictureUrl;

//nightPictureUrl
@property (nonatomic,strong) NSString * nightPictureUrl;

//weather
@property (nonatomic,strong) NSString * weather;

//wind
@property (nonatomic,strong) NSString * wind;

//temperature
@property (nonatomic,strong) NSString * temperature;

//天气数组
@property (nonatomic,strong) NSMutableArray * skyArr;










@end
