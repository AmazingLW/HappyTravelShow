//
//  WeatherDetailCell.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailCell : UITableViewCell

@property(nonatomic,strong) UIImageView  *locationView;
//地方
@property(nonatomic,strong) UILabel  *lab4weatherPlace;
//今天的日期
@property(nonatomic,strong) UILabel  *lab4todayData;
//今天的温度
@property(nonatomic,strong) UILabel  *lab4todayTemperature;
//天气状况
@property(nonatomic,strong) UILabel  *lab4weather;
//天气状况图片
@property(nonatomic,strong) UIImageView  *weatherView;
//明天天气
@property(nonatomic,strong) UILabel  *tomorrowWeather;
@property(nonatomic,strong) UILabel  *tomorrowTemperature;
@property(nonatomic,strong) UILabel  *tomorrowData;
//后天
@property(nonatomic,strong) UILabel  *afterTomorrowWeather;
@property(nonatomic,strong) UILabel  *afterTomorrowTemperature;
@property(nonatomic,strong) UILabel  *afterTomorrowData;
//大后天
@property(nonatomic,strong) UILabel  *threeDaysWeather;
@property(nonatomic,strong) UILabel  *threeDaysTemperature;
@property(nonatomic,strong) UILabel  *threeDaysData;




@end
