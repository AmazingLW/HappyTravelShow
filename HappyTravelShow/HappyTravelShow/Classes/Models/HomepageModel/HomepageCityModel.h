//
//  HomepageCityModel.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageCityModel : NSObject
//product详情id
@property(nonatomic,assign) NSInteger  productId;
//标题
@property(nonatomic,strong) NSString  *productName;
//标题内容
@property(nonatomic,strong) NSString  *productTitleContent;
//价格
@property(nonatomic,assign) NSInteger  price;
//原价
@property(nonatomic,assign) NSInteger  retailPrice;
//已售数量
@property(nonatomic,assign) NSInteger   saledCount;
//图片链接
@property(nonatomic,strong) NSString  *homeImageUrl;

//所属城市
@property(nonatomic,strong) NSString*  city;

//package详情id
@property(nonatomic,assign) NSInteger  channelLinkId;

@end
