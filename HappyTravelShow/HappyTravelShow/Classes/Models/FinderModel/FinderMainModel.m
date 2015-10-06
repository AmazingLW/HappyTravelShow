//
//  FinderMainModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FinderMainModel.h"

@implementation FinderMainModel
 
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.numDescription=value;
    
    }else{
        
        NSLog(@"KVC出错");
    }
    
    
}


@end
