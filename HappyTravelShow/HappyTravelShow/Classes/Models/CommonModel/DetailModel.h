//
//  DetailModel.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

//productId
@property (nonatomic,strong) NSString * productId;

//channelLinkId
@property (nonatomic,strong) NSString * channelLinkId;

//productName
@property (nonatomic,strong) NSString * productName;

//mainTitle
@property (nonatomic,strong) NSString * mainTitle;

//subTitle
@property (nonatomic,strong) NSString * subTitle;

//appMainTitle
@property (nonatomic,strong) NSString * appMainTitle;

//appSubTitle
@property (nonatomic,strong) NSString * appSubTitle;

//sellPrice
@property (nonatomic,strong) NSString * sellPrice;

//retailPrice
@property (nonatomic,strong) NSString * retailPrice;

//startDate
@property (nonatomic,strong) NSString * startDate;

//endDate
@property (nonatomic,strong) NSString * endDate;

//openTime
@property (nonatomic,strong) NSString * openTime;

//goodRate
@property (nonatomic,strong) NSString * goodRate;

//commentCount
@property (nonatomic,strong) NSString * commentCount;

//longitude
@property (nonatomic,strong) NSString * longitude;

//latitude
@property (nonatomic,strong) NSString * latitude;

//provinceId
@property (nonatomic,strong) NSString * provinceId;

//provinceName
@property (nonatomic,strong) NSString * provinceName;

//cityId
@property (nonatomic,strong) NSString * cityId;

//cityName
@property (nonatomic,strong) NSString * cityName;

//address
@property (nonatomic,strong) NSString * address;

//saledCount
@property (nonatomic,strong) NSString * saledCount;

//telphone
@property (nonatomic,strong) NSString * telphone;

//packageDetial
@property (nonatomic,strong) NSString * packageDetial;

//trafficGuide
@property (nonatomic,strong) NSString * trafficGuide;

//bookNotice
@property (nonatomic,strong) NSString * bookNotice;

//productIntroduction
@property (nonatomic,strong) NSString * productIntroduction;

//imageList  头部图片
@property (nonatomic,strong) NSMutableArray * imgArr;

//imageId
@property (nonatomic,strong) NSString * imageId;

//title
@property (nonatomic,strong) NSString * title;

//url
@property (nonatomic,strong) NSString * url;

//sortOrder
@property (nonatomic,strong) NSString * sortOrder;

//-------weather_Data value 是 数组

//存放天气信息的数组
@property (nonatomic,strong) NSMutableArray * weathcerArr;

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






































@end
