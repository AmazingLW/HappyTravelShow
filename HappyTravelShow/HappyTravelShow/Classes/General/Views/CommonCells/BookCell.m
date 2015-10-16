//
//  BookCell.m
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "BookCell.h"

@interface BookCell ()

@property (nonatomic,strong) UIView * backView;

@end


@implementation BookCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       //背景视图初始化
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        [self addSubview:_backView];
        
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 230, 80)];
        self.titleLabel.numberOfLines = 0;

        
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [_backView addSubview:self.titleLabel];
        
        //价格
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 23, 60, 30)];
        self.priceLabel.textColor = [UIColor orangeColor];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        [_backView addSubview:self.priceLabel];
        
        
//        //预订按钮
//        UIButton *bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        bookBtn.frame = CGRectMake(kScreenWidth - 70,15,65, 40);
//        bookBtn.backgroundColor = [UIColor orangeColor];
//        bookBtn.layer.masksToBounds = YES;
//        bookBtn.layer.cornerRadius = 3;
//        [bookBtn setTitle:@"预订" forState:UIControlStateNormal];
//        [_backView addSubview:bookBtn];
        
        
        
    }
    return self;
}


- (void)setModel:(BookModel *)model{
    self.titleLabel.text = model.packageName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.miniPrice];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
