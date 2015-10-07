//
//  HomepagePackageModel.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepagePackageModel : NSObject
@property(nonatomic,strong)NSString*labelText,*bigImageUrl,*cityName,*productName,*productTitleContent;
@property(nonatomic,assign)NSInteger price,originalPrice,saledCount;
@end
