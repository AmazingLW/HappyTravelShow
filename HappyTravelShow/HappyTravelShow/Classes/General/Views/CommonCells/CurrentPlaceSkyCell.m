//
//  CurrentPlaceSkyCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CurrentPlaceSkyCell.h"
#import "UIImageView+WebCache.h"

@interface CurrentPlaceSkyCell ()
{
    UIView *_backView;
}

@end

@implementation CurrentPlaceSkyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 105)];
        [self addSubview:_backView];
        
        
        //城市
        self.cityName = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 60, 20)];
        self.cityName.font = [UIFont systemFontOfSize:20];
        [_backView addSubview:self.cityName];
        
        //温度
        self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 35, 130, 40)];
        self.tempLabel.font = [UIFont systemFontOfSize:25];
        self.tempLabel.textColor = [UIColor orangeColor];
        [_backView addSubview:self.tempLabel];
        
        //日期
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 75, 120, 20)];
        self.dateLabel.font = [UIFont systemFontOfSize:20];
        [_backView addSubview:self.dateLabel];
        
        //图标
        self.imgType = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 35, 30, 20)];
        [_backView addSubview:self.imgType];
        
        
        //类型
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 75, 70, 60, 30)];
        self.typeLabel.font = [UIFont systemFontOfSize:20];
        [_backView addSubview:self.typeLabel];
        
    }
    return self;
}

- (void)setCurrentDayWithCityName:(NSString *)cityName temperature:(NSString *)temperature date:(NSString *)date typeImg:(NSString *)imgUrl type:(NSString *)type{
    self.cityName.text = cityName;
    NSArray *arr = [date componentsSeparatedByString:@" "];
    self.dateLabel.text = arr[1];
    self.tempLabel.text = temperature;
    self.typeLabel.text = type;
    [self.imgType sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
