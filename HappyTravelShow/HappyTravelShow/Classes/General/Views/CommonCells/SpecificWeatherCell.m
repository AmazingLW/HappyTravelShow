//
//  SpecificWeatherCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "SpecificWeatherCell.h"
#import "DetailModel.h"

@interface SpecificWeatherCell ()
{
    UIView *backView;
}

@property (nonatomic,strong) UILabel * firstDay;
@property (nonatomic,strong) UILabel * firstDayTemp;

@property (nonatomic,strong) UILabel * secondDay;
@property (nonatomic,strong) UILabel * secondDayTemp;

@property (nonatomic,strong) UILabel * thirdDay;
@property (nonatomic,strong) UILabel * thirdDayTemp;


@end

@implementation SpecificWeatherCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 105)];
        [self addSubview:backView];
        
        //1
        self.firstDay = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 150, 30)];
        self.firstDayTemp = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 5, 85, 30)];
        [backView addSubview:self.firstDay];
        [backView addSubview:self.firstDayTemp];

        //2
        self.secondDay = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, 150, 30)];
        self.secondDayTemp = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 40, 85, 30)];
        [backView addSubview:self.secondDay];
        [backView addSubview:self.secondDayTemp];
        
        //3
        self.thirdDay = [[UILabel alloc] initWithFrame:CGRectMake(25, 75, 150, 30)];
        self.thirdDayTemp = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 75, 85, 30)];
        [backView addSubview:self.thirdDay];
        [backView addSubview:self.thirdDayTemp];
        
        
    }
    return self;
}


- (void)setSpecificeViewWithArr:(NSArray *)arr{
    
    DetailModel *model1 = arr[1];
    self.firstDay.text = model1.date;
    self.firstDayTemp.text = model1.temperature;
    DetailModel *model2 = arr[2];
    self.secondDay.text = model2.date;
    self.secondDayTemp.text = model2.temperature;
    
    DetailModel *model3 = arr[3];
    self.thirdDay.text = model3.date;
    self.thirdDayTemp.text = model3.temperature;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
