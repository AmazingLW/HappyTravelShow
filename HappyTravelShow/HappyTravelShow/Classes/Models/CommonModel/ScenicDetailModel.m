//
//  ScenicDetailModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "ScenicDetailModel.h"

@implementation ScenicDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    
    //套餐
    if ([key isEqualToString:@"product"]) {
        NSArray *mealArr = (NSArray *)value;
        NSDictionary *mealdict = mealArr.firstObject;
        NSArray *detailArr = mealdict[@"product"];
        
        for (NSDictionary *d in detailArr) {
            ScenicDetailModel *model = [ScenicDetailModel new];
            [model setValuesForKeysWithDictionary:d];
            [self.mealMuaArr addObject:model];
        }
    }
    
    //photoAlbum
    if ([key isEqualToString:@"photoAlbum"]) {
        NSArray * arr = (NSArray *)value;
        for (NSDictionary *dict in arr) {
            ScenicDetailModel *model = [ScenicDetailModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.photoMuaArr addObject:model];
        }
    }
    
    //hotRecommendation
    if ([key isEqualToString:@"hotRecommendation"]) {
        NSDictionary *dict = (NSDictionary *)value;
        ScenicDetailModel *model = [ScenicDetailModel new];
        [model setValuesForKeysWithDictionary:dict];
        [self.baokuanArr addObject:model];
    }
    
}


- (NSMutableArray *)mealMuaArr{
    if (_mealMuaArr == nil) {
        _mealMuaArr = [NSMutableArray array];
    }
    return _mealMuaArr;
}

- (NSMutableArray *)photoMuaArr{
    if (_photoMuaArr == nil) {
        _photoMuaArr = [NSMutableArray array];
    }
    return _photoMuaArr;
}

- (NSMutableArray *)baokuanArr{
    if (_baokuanArr == nil) {
        _baokuanArr = [NSMutableArray array];
    }
    return _baokuanArr;
}





@end
