//
//  DetailModel.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    //weatherInfo
    if ([key isEqualToString:@"weatherInfo"]) {
        NSArray *weatherArray = (NSArray *)value;
        NSDictionary *weathcerDict =  weatherArray.firstObject;
        //当前城市的天气情况 数组
        NSArray *currentCityWeather = weathcerDict[@"weather_Data"];
        _weathcerArr = [NSMutableArray array];
        for (NSDictionary *d in currentCityWeather) {
            DetailModel *model = [DetailModel new];
            model.date = d[@"date"];
            model.dayPictureUrl = d[@"dayPictureUrl"];
            model.nightPictureUrl = d[@"nightPictureUrl"];
            model.weather = d[@"weather"];
            model.wind = d[@"wind"];
            model.temperature = d[@"temperature"];
            [self.weathcerArr addObject:model];
        }
    }
    
    //imageList
    if ([key isEqualToString:@"imageList"]) {
        NSArray *array = (NSArray *)value;
        _imgArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            DetailModel *model = [DetailModel new];
            model.imageId = dict[@"imageId"];
            model.title = dict[@"title"];
            model.url = dict[@"url"];
            model.sortOrder = dict[@"sortOrder"];
            [self.imgArr addObject:model];
        }
    }
    
}





@end
