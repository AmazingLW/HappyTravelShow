//
//  CurrentPlaceSkyCell.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentPlaceSkyCell : UITableViewCell

@property (nonatomic,strong) UILabel * cityName;

@property (nonatomic,strong) UILabel * tempLabel;

@property (nonatomic,strong) UILabel * dateLabel;

@property (nonatomic,strong) UIImageView * imgType;

@property (nonatomic,strong) UILabel * typeLabel;



- (void)setCurrentDayWithCityName:(NSString *)cityName temperature:(NSString *)temperature date:(NSString *)date typeImg:(NSString *)imgUrl type:(NSString *)type;




@end
