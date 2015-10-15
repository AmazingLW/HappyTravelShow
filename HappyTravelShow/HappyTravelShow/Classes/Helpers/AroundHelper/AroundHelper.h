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

//当目的城市选定 景点全部时 列表
- (void)requsetAllScenicsWithScenicName:(NSString *)scenicName finish:(void(^)(NSArray *scenic))result;



//列表小景点
- (void)requestLittleScenicWithScenicName:(NSString *)scenicName cityName:(NSString *)cityName finish:(void (^)(NSArray * array))result;

//筛选
//当 目的城市为全部 景点全部  排序方式改变   筛选方式改变  city(景德镇)
//#define chooseAllScenic(sortType,tagName,cityName)
- (void)chooseScenicWithSortType:(NSString *)sortType TagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;


// 当目的城市选定 景点选定 排序方式 sortType 任意  筛选方式改变  景点(scenicName) 三清山  city(是目的城市 @"上饶")
//如果 scenicName 为空时   使用另一个URl 筛选 当目的城市选定 景点全部 排序方式 sortType 任意  筛选方式改变  city(是目的城市 @"上饶")

- (void)chooseScenicWithScenicName:(NSString *)scenicName SortType:(NSString *)sortType TagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;





//排序  目的城市全部 景点全部 city传进来的城市 (景德镇的经纬度)

- (void)sortDataWithType:(NSString *)type cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;

//排序  目的城市选定 景点全部  cityName(选定的目的城市) (上饶)

- (void)partSortDataWithType:(NSString *)type cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;

//排序 目的城市选定 景点选定


- (void)littleSortDataWithScenicName:(NSString *)scenicName type:(NSString *)type cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;




//---------------------------------------------------


//正确的方法
//#define partScenicList(scenicName,sort,tagName,cityName)
//如果筛选是全部 那么也就是tagName =nil 那么 执行这个scenicList(scenicName,sort,cityName)
//如果筛选不是全部 也就是tagName != nil 那么执行这个partScenicList(scenicName,sort,tagName,cityName)


- (void) requestDataFromURLStringWithScenicName:(NSString *)scenicName sort:(NSString *)sort tagName:(NSString *)tagName cityName:(NSString *)cityName finish:(void(^)(NSArray * array))result;


// 热门城市

- (void)requestHotCityWithCityID:(NSInteger)cityID result:(void (^)(NSArray * array))result;


//热门城市
- (void)requestHotCityListWithKeyWord:(NSString *)keyWord city:(NSString *)city result:(void(^)(NSArray * array)) result;



@end
