//
//  HomepagePackageModel.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepagePackageModel.h"

@implementation HomepagePackageModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    NSLog(@"");
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _bigImageUrl];
}
@end
