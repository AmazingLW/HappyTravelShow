//
//  ScenicDetailModel.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScenicDetailModel : NSObject

//productId
@property (nonatomic,strong) NSString * productId;

//productTitleContent
@property (nonatomic,strong) NSString * productTitleContent;

//imageListCount
@property (nonatomic,strong) NSString * imageListCount;

//price
@property (nonatomic,strong) NSString * price;

//originalPrice
@property (nonatomic,strong) NSString * originalPrice;

//saledCount
@property (nonatomic,strong) NSString * saledCount;

//provinceName
@property (nonatomic,strong) NSString * provinceName;

//cityName
@property (nonatomic,strong) NSString * cityName;

//address
@property (nonatomic,strong) NSString * address;

//longitude
@property (nonatomic,strong) NSString * longitude;

//latitude
@property (nonatomic,strong) NSString * latitude;

//distance
@property (nonatomic,strong) NSString * distance;

//channelLinkId
@property (nonatomic,strong) NSString * channelLinkId;

//type
@property (nonatomic,strong) NSString * type;

//productName
@property (nonatomic,strong) NSString * productName;

//productDescription
@property (nonatomic,strong) NSString * productDescription;

//productTitle
@property (nonatomic,strong) NSString * productTitle;

//mImageUrl
@property (nonatomic,strong) NSString * mImageUrl;

//sort
@property (nonatomic,strong) NSString * sort;

//保存套餐信息的数组
@property (nonatomic,strong) NSMutableArray * mealMuaArr;


//scenicId
@property (nonatomic,strong) NSString * scenicId;

//scenicName
@property (nonatomic,strong) NSString * scenicName;

//scenicAlias
@property (nonatomic,strong) NSString * scenicAlias;

//coverPic
@property (nonatomic,strong) NSString * coverPic;

//endDate
@property (nonatomic,strong) NSString * endDate;

//openTime
@property (nonatomic,strong) NSString * openTime;

//file
@property (nonatomic,strong) NSString * file;

//fileId
@property (nonatomic,strong) NSString * fileId;

//title
@property (nonatomic,strong) NSString * title;

//intro
@property (nonatomic,strong) NSString * intro;

//shareIntro
@property (nonatomic,strong) NSString * shareIntro;

//保存照片信息的数组
@property (nonatomic,strong) NSMutableArray * photoMuaArr;

//保存当即爆款的信息
@property (nonatomic,strong) NSMutableArray * baokuanArr;






















@end
