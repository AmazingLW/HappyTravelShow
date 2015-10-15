//
//  FinderKindModel.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinderKindModel : NSObject
//标题
@property(nonatomic,strong) NSString  *productName;
//标题内容
@property(nonatomic,strong) NSString  *productTitleContent;
//价格
@property(nonatomic,strong) NSNumber  *price;
//原价
@property(nonatomic,strong) NSNumber  *originalPrice;
//已售数量
@property(nonatomic,strong) NSNumber   *saledCount;
//所属城市
@property(nonatomic,strong) NSString  *cityName;
//图片链接
@property(nonatomic,strong) NSString  *URL;
//product详情id
@property(nonatomic,strong) NSString  *productId;
//package详情id
@property(nonatomic,strong) NSString  *channelLinkId;

@end
