//
//  SDHeaderCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "SDHeaderCell.h"
#import "UIImageView+WebCache.h"


@interface SDHeaderCell ()


@property (nonatomic,strong) UIImageView * headerImgView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UIButton * backBtn;
@property (nonatomic,strong) UIButton * shareBtn;

@end

@implementation SDHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        _headerImgView.userInteractionEnabled = YES;
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(10, 13, 40, 40);
        [_backBtn setImage:[UIImage imageNamed:@"detailBack"] forState:UIControlStateNormal];
        _backBtn.alpha = 0.6;
        [_backBtn addTarget:self action:@selector(backToHomepage) forControlEvents:UIControlEventTouchUpInside];
        
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(kScreenWidth - 50, 13, 40, 40);
        [_shareBtn setImage:[UIImage imageNamed:@"detailshare"] forState:UIControlStateNormal];
        _shareBtn.alpha = 0.6;
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 100, 30)];
        _nameLabel.text = @"天安门";
        _nameLabel.textColor = [UIColor whiteColor];
        
        [_headerImgView addSubview:_nameLabel];
        
        [_headerImgView addSubview:_backBtn];
        [_headerImgView addSubview:_shareBtn];
        
        [self.contentView addSubview:_headerImgView];
    }
    
    return self;
}

- (void)backToHomepage{
    NSLog(@"返回");
    
}

- (void)shareAction{
    NSLog(@"分享");
}

- (void)setViewWithTitle:(NSString *)strTitle coverPic:(NSString *)coverPic{
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:coverPic]];
    self.nameLabel.text = strTitle;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
