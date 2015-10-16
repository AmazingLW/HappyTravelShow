//
//  WeatherDetailCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "WeatherDetailCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHegiht [UIScreen mainScreen].bounds.size.height


@implementation WeatherDetailCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self drawView];
    }
    return self;
    
    
}

- (void)drawView{
    
    //今天的天气数据
    self.locationView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 18, 15, 15)];
    self.lab4weatherPlace=[[UILabel alloc]initWithFrame:CGRectMake( 45, 13, 40, 25)];
    self.lab4weatherPlace.font=[UIFont systemFontOfSize:15];
    
    self.lab4todayData=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-50, 38, kWidth-100, 20)];
    self.lab4todayData.font=[UIFont systemFontOfSize:15];
    
    self.lab4todayTemperature=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-68, 55, kWidth-130,60)];
    self.lab4todayTemperature.font=[UIFont systemFontOfSize:35];
    self.lab4todayTemperature.textColor=[UIColor orangeColor];
    
    self.weatherView=[[UIImageView alloc]initWithFrame:CGRectMake(kWidth/2-34, 112, 20, 20)];
    
    self.lab4weather=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-4, 109, 80, 30)];
    self.lab4weather.font=[UIFont systemFontOfSize:15];
  //========================================================
    
    
    [self.contentView addSubview:self.locationView];
    [self.contentView addSubview:self.lab4weatherPlace];
    [self.contentView addSubview:self.lab4weather];
    [self.contentView addSubview:self.lab4todayTemperature];
    [self.contentView addSubview:self.weatherView];
    [self.contentView addSubview:self.lab4todayData];
    
    
    
     
    self.tomorrowData=[[UILabel alloc]initWithFrame:CGRectMake(20, 13, 80, 30)];
    self.afterTomorrowData=[[UILabel alloc]initWithFrame:CGRectMake(20, 50,80, 30)];
    self.threeDaysData=[[UILabel alloc]initWithFrame:CGRectMake(20, 87, 80, 30)];
    
    self.tomorrowWeather=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-20, 13, 80, 30)];
    self.tomorrowWeather.textAlignment= NSTextAlignmentRight;
    self.afterTomorrowWeather=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-20, 50, 80, 30)];
    self.afterTomorrowWeather.textAlignment= NSTextAlignmentRight;
    self.threeDaysWeather=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2-20, 87, 80, 30)];
   self.threeDaysWeather.textAlignment= NSTextAlignmentRight;
    

    self.tomorrowTemperature=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2+80, 13, 80, 30)];
    self.afterTomorrowTemperature=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2+80, 50, 80, 30)];
    self.threeDaysTemperature=[[UILabel alloc]initWithFrame:CGRectMake(kWidth/2+80,  87, 80, 30)];

    
    
    
    
    
    
    [self.contentView addSubview:self.tomorrowData];
    [self.contentView addSubview:self.afterTomorrowData];
    [self.contentView  addSubview:self.threeDaysData];
    
    [self.contentView addSubview:self.tomorrowWeather];
    [self.contentView addSubview:self.afterTomorrowWeather];
    [self.contentView addSubview:self.threeDaysWeather];

    
    [self.contentView addSubview:self.tomorrowTemperature];
    [self.contentView addSubview:self.afterTomorrowTemperature];
    [self.contentView addSubview:self.threeDaysTemperature];

    
}







- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
