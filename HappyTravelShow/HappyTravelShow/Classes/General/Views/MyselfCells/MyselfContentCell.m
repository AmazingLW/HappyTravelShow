//
//  MyselfContentCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "MyselfContentCell.h"
#define kWdith [UIScreen mainScreen].bounds.size.width

@implementation MyselfContentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self drawView];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
    
    
}

- (void)drawView{
    
    self.titleView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 24, 24)];
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(58, 12, 150, 14)];
    self.cacheLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 135, 12, 100, 14)];
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.cacheLabel];
    
    
}
 





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
