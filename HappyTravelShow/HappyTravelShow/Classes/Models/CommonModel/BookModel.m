//
//  BookModel.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"serviceFacilities"]) {
        NSArray *arr = value;
        _serviceFacilitiesArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            BookModel *model = [BookModel new];
            model.name = dict[@"name"];
            model.icon = dict[@"icon"];
            model.isShowInList = dict[@"isShowInList"];
            [_serviceFacilitiesArr addObject:model];
            
        }
    }
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"packageName:%@", _packageName];
}


@end
