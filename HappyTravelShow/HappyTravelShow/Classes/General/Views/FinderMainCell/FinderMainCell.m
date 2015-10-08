//
//  FinderMainCell.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "FinderMainCell.h"
#import "UIImageView+WebCache.h"


@implementation FinderMainCell

- (void)setMainModel:(FinderMainModel *)mainModel{
    
    
    self.lab4title.text=mainModel.title;
    self.lab4subTitle.text=mainModel.subTitle;
    self.lab4location.text=mainModel.districtName;
    [self.FinderMain4imageView sd_setImageWithURL:[NSURL URLWithString:mainModel.imageUrl]];
    self.FinderMain4imageView.layer.cornerRadius=5;
    self.FinderMain4imageView.layer.masksToBounds=YES;
    self.view.alpha=0.8;
    
}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
