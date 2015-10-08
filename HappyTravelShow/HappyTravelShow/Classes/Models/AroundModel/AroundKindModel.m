//
//  AroundKindModel.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundKindModel.h"
#import "FinderURL.h"
@implementation AroundKindModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:_URL]) {
        self.URL = kURL(value);
    }
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%ld,%ld", _price,_productId];
}
@end
