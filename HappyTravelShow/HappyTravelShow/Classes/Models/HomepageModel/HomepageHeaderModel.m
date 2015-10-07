//
//  HomepageHeaderModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepageHeaderModel.h"

@implementation HomepageHeaderModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"new_app_picpath"]) {
        _n_app_picpath= (NSString *)value;
    }
    NSLog(@"");
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _app_picpath];
}
@end
