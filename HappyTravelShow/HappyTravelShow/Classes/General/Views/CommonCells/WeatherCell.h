//
//  WeatherCell.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell

//天气图标 uiimgview
@property (nonatomic,strong) UIImageView * weatherImgView;

//地区
@property (nonatomic,strong) UILabel * placeLabel;

//日期
@property (nonatomic,strong) UILabel * dateLabel;

//温度
@property (nonatomic,strong) UILabel * tempLabel;

//天气状况
@property (nonatomic,strong) UILabel * typeLabel;

- (void)setWeatherViewWithCityname:(NSString *)cityName date:(NSString *)date temperature:(NSString *)temperature typeDay:(NSString *)typeDay;

@end
