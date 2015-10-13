//
//  SkyModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "SkyModel.h"

@implementation SkyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"weather_Data"]) {
        _skyArr = [NSMutableArray array];
        NSArray *arr = (NSArray *)value;
        for (NSDictionary *d in arr) {
            SkyModel *model = [SkyModel new];
            [model setValuesForKeysWithDictionary:d];
            [_skyArr addObject:model];
        }
        
    }
}


@end
