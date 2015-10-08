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



//所有景点数据
- (void)requsetAllScenicsWithCityName:(NSString *)name finish:(void(^)(NSArray *scenic))result;
//列表小景点
- (void)requestLittleScenicWithCithName:(NSString *)cityName scenicName:(NSString *)scenicName finish:(void (^)(NSArray * array))result;

//当目的城市为全部使筛选  cityName 是定位时的城市
- (void)chooseScenicWithTagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;





@end
