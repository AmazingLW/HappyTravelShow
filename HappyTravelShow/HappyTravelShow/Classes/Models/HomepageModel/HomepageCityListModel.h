//
//  HomepageCityListModel.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageCityListModel : NSObject
@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *pinYinName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityNameAbbr;
@property (nonatomic, assign) BOOL isHot;
@end
