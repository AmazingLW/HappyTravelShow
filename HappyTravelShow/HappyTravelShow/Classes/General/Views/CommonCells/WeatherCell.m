//
//  WeatherCell.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "WeatherCell.h"

@implementation WeatherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图标
        self.weatherImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 20, 20)];
        self.weatherImgView.image =[UIImage imageNamed:@"place"];
        [self addSubview:self.weatherImgView];
        
        //地区
        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 250, 30)];
        self.placeLabel.font = [UIFont systemFontOfSize:15];
        self.placeLabel.textColor = [UIColor grayColor];
        [self addSubview:self.placeLabel];
        
        //日期
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 100, 30)];
        self.dateLabel.font = [UIFont systemFontOfSize:13];
        self.dateLabel.textColor = [UIColor grayColor];
        [self addSubview:self.dateLabel];
        
        //温度
        self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 100, 30)];
        self.tempLabel.font = [UIFont systemFontOfSize:13];
        self.tempLabel.textColor = [UIColor grayColor];
        [self addSubview:self.tempLabel];
        
        //天气状态
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 40, 30, 30)];
        self.typeLabel.font = [UIFont systemFontOfSize:13];
        self.typeLabel.textColor = [UIColor grayColor];
        [self addSubview:self.typeLabel];
        
    }
    return self;
}


- (void)setWeatherViewWithCityname:(NSString *)cityName date:(NSString *)date temperature:(NSString *)temperature typeDay:(NSString *)typeDay{
    self.placeLabel.text = cityName;
    NSArray *arr = [date componentsSeparatedByString:@" "];
    self.dateLabel.text = arr[1];
    self.tempLabel.text = temperature;
    self.typeLabel.text = typeDay;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
