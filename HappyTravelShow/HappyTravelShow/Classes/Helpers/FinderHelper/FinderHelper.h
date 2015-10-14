//
//  FinderHelper.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinderHelper : NSObject

//单例方法
+ (FinderHelper *)sharedHelper;

//发现主页面请求数据
- (void)getDataWithCityCode:(NSString *)cityCode pageIndex:(NSInteger )pageIndex Finish:(void(^)())result;

//外界可用到的发现主页面数据的数组
@property(nonatomic,strong) NSArray  *dataArray;
//外界可用到的发现各种景点的数组
@property(nonatomic,strong) NSArray  *kindArray;

- (void)requestDataWithThemeId:(NSString *)themeId cityCode:(NSString *)cityCode pageIndex:(NSString *)pageIndex Finish:(void (^)())result;

@end
