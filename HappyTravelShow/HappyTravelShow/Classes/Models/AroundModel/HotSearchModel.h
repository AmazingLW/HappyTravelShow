//
//  HotSearchModel.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotSearchModel : NSObject

//product详情id
@property(nonatomic,assign) NSInteger  productId;
//标题
@property(nonatomic,strong) NSString  *appMainTitle;
//标题内容
@property(nonatomic,strong) NSString  *appSubTitle;
//价格
@property(nonatomic,assign) NSInteger  price;
//原价
@property(nonatomic,assign) NSInteger  retailPrice;
//已售数量
@property(nonatomic,assign) NSInteger   saledCount;
//图片链接  拼接http://cdn1.jinxidao.com/

@property(nonatomic,strong) NSString  *appImageUrl;

//所属城市
@property(nonatomic,strong) NSString  *city;

//package详情id
@property(nonatomic,assign) NSInteger  channelLinkId;

@end
