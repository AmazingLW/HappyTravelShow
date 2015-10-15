//
//  HotSearchModel.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HotSearchModel.h"

@implementation HotSearchModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    // NSLog(@"kvc出错%@",key);
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%ld,%ld", _price,_productId];
}

@end
