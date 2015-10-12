//
//  MealDetailCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/11.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "MealDetailCell.h"
#import "UIImageView+WebCache.h"

@interface MealDetailCell ()
{
    UIView *_backView;
}
@property (nonatomic,strong) UIImageView * backImgView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * describLabel;
@property (nonatomic,strong) UILabel * nowPriceLabel;
@property (nonatomic,strong) UILabel * oldPriceLabel;
@property (nonatomic,strong) UILabel * sellLabel;



@end


@implementation MealDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 230)];
        [self addSubview:_backView];
        
        //背景图片
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 135)];
        [_backView addSubview:_backImgView];
        
        //title
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 230, 30)];
        _titleLabel.text = @"北京古水镇酒店";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        [_backView addSubview:_titleLabel];
        
        
        //描述
        _describLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 135, kScreenWidth - 50, 50)];
        _describLabel.text = @"数据的覅数据覅就斯蒂芬及时的飞机设计覅";
        _describLabel.numberOfLines = 0;
        [_backView addSubview:_describLabel];
        
        //价格
        _nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 195, 90, 20)];
        _nowPriceLabel.textColor = [UIColor orangeColor];
        _nowPriceLabel.font = [UIFont systemFontOfSize:22];
        _nowPriceLabel.text = @"￥518";
        [_backView addSubview:_nowPriceLabel];
        
        //旧价格
        _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 50, 20)];
        _oldPriceLabel.textColor = [UIColor grayColor];
        _oldPriceLabel.font = [UIFont systemFontOfSize:14];
        _oldPriceLabel.text = @"￥123";
        [_backView addSubview:_oldPriceLabel];
        
        //销量
        _sellLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 200, 80, 20)];
        _sellLabel.textColor = [UIColor grayColor];
        _sellLabel.font = [UIFont systemFontOfSize:14];
        _sellLabel.text = @"已售1948";
        [_backView addSubview:_sellLabel];
        
    }
    return self;
}


- (void)setViewWithModel:(ScenicDetailModel *)model{
    [_backImgView sd_setImageWithURL:[NSURL URLWithString:model.mImageUrl]];
    _titleLabel.text = model.productName;
    _describLabel.text = model.productDescription;
    _nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    _oldPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.originalPrice];
    _sellLabel.text = [NSString stringWithFormat:@"已售%@",model.saledCount];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
