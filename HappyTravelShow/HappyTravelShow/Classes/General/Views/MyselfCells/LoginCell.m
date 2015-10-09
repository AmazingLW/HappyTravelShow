//
//  LoginCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "LoginCell.h"

@implementation LoginCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
        
    }
    return self;
    
}

- (void)drawView{
    
    self.loginView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 30, 30)];
    
    [self.contentView addSubview:self.loginView];
    
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
