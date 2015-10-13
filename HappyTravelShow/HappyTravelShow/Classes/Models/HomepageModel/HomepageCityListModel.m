//
//  HomepageCityListModel.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepageCityListModel.h"

@implementation HomepageCityListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    // NSLog(@"kvc出错%@",key);
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@",_cityName,_pinYinName];
}

@end
