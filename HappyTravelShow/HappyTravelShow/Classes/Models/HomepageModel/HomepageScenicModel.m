//
//  HomepageScenicModel.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepageScenicModel.h"

@implementation HomepageScenicModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _cityId= (NSString *)value;
    }
    NSLog(@"");
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@", _name,_cityId,_cityCode];
}
@end
