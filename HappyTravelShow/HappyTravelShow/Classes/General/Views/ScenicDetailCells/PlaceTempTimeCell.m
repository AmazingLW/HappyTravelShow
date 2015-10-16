//
//  PlaceTempTimeCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "PlaceTempTimeCell.h"

@interface PlaceTempTimeCell ()

@property (nonatomic,strong) UIImageView * iconImgView;

@property (nonatomic,strong) UILabel * typeLabel;

@property (nonatomic,strong) UILabel * detailLabel;

@end



@implementation PlaceTempTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
        _iconImgView.image = [UIImage imageNamed:@"location"];
        [self addSubview:_iconImgView];
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 7, 80, 10)];
        _typeLabel.font = [UIFont systemFontOfSize:15];
        _typeLabel.textColor = [UIColor grayColor];
        [self addSubview:_typeLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 28, 260, 20)];

        [self addSubview:_detailLabel];
        
        
    }
    return self;
}


- (void)setViewWithIndex:(NSInteger)index strDetail:(NSString *)strDetail{
    if (index == 0) {
        _typeLabel.text = @"地址";
        _iconImgView.image = [UIImage imageNamed:@"location"];
    }else if (index == 2){
        _typeLabel.text = @"开放时间";
        _iconImgView.image = [UIImage imageNamed:@"shijian"];
    }
    self.detailLabel.text = strDetail;
}

- (void)setViewWithObject:(SkyModel *)model{
    _typeLabel.text = @"天气";
    _iconImgView.image = [UIImage imageNamed:@"tianqi"];
    self.detailLabel.text = [NSString stringWithFormat:@"今日%@%@",model.temperature,model.weather];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
