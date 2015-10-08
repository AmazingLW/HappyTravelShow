//
//  AroundHelper.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AroundHelper.h"
@interface AroundHelper : NSObject


//根据城市名 获取目的城市和景点名列表

- (void)requestWithCityName:(NSString *)name finish:(void (^)(NSArray * array))result;

- (void)requsetAllScenicsWithCityName:(NSString *)name finish:(void(^)(NSArray *scenic))result;

- (void)requestLittleScenicWithCithName:(NSString *)cityName scenicName:(NSString *)scenicName finish:(void (^)())result;

@end
