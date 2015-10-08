//
//  AroundMainModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AroundMainModel.h"

@implementation AroundMainModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"kvc出错%@",key);
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@",_city,_scenics,_tags];
}

@end
