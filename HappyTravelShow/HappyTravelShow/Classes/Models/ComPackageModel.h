//
//  ComPackageModel.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComPackageModel : NSObject
@property(nonatomic,strong)NSString*labelText,*bigImageUrl,*cityName,*productName,*productTitleContent;
@property(nonatomic,assign)NSInteger price,originalPrice,saledCount;

@end
