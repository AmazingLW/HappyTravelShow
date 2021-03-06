//
//  HomepageHelper.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageHelper : NSObject


//轮播图
- (void)requestAllPackage:(NSString*)title
             withCityCode:(NSString*)cityCode
               WithFinish:(void (^)(NSMutableArray *arr))result;
//城市
//- (void)requestAllCity:(NSString*)kind
//            WithFinish:(void (^)(NSMutableArray *arr))result;
- (void)requestAllCity:(NSString*)kind
          withCityCode:(NSString*)cityCode
            WithFinish:(void (^)(NSMutableArray *arr))result;
//精品推荐
//- (void)requestAllRecommendation:(void (^)(NSMutableArray *arr))result;
- (void)requestAllRecommendation:(NSString*)cityCode
                      WithFinish:(void (^)(NSMutableArray *arr))result;
//点击门票and温泉
//- (void)requestAllTicket:(NSString*)tagId
//                withSort:(NSString*)sort
//                cityName:(NSString*)cityName
//              WithFinish:(void (^)(NSMutableArray *arr))result;
- (void)requestAllTicket:(NSString*)tagId
                    page:(NSInteger)page
                withSort:(NSString*)sort
                cityName:(NSString*)cityName
              WithFinish:(void (^)(NSMutableArray *arr))result;

//点击亲子游and市区
//- (void)requestAllFamily:(NSString*)tagId
//                withSort:(NSString*)sort
//                cityName:(NSString*)cityName
//              WithFinish:(void (^)(NSMutableArray *arr))result;

- (void)requestAllFamily:(NSInteger)page
                   tagld:(NSString*)tagId
                withSort:(NSString*)sort
                cityName:(NSString*)cityName
              WithFinish:(void (^)(NSMutableArray *arr))result;
//点击周边城市
//- (void)requestAllCityDetail:(NSString*)citycold
//                    cityName:(NSString*)cityName
//                    withSort:(NSInteger)sort
//                  WithFinish:(void (^)(NSMutableArray *arr))result;
- (void)requestAllCityDetail:(NSInteger)p
                    citycold:(NSString*)citycold
                    cityName:(NSString*)cityName
                    withSort:(NSInteger)sort
                  WithFinish:(void (^)(NSMutableArray *arr))result;
//所有城市列表
-(void)requestallCityList:(NSString*)kind
               WithFinish:(void (^)(NSMutableArray *arr))result;
@end
