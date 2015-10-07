//
//  FinderKindModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FinderKindModel.h"
#import "FinderURL.h"

@implementation FinderKindModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"url"]) {
        self.url=kURL(value);
        
    }
    
}



@end
