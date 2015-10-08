//
//  CommonCells.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CommonCells.h"
#import "UIImageView+WebCache.h"

@implementation CommonCells

- (void)setKindModel:(FinderKindModel *)kindModel{
    self.lab4productName.text=kindModel.productName;
    self.lab4productTitleContent.text=[NSString stringWithFormat:@"[%@] %@",kindModel.cityName,kindModel.productTitleContent];
    self.lab4productTitleContent.numberOfLines=0;
    self.lab4price.text=[NSString stringWithFormat:@"%@",kindModel.price];
    self.lab4originalPrice.text=[NSString stringWithFormat:@"%@",kindModel.originalPrice];
    self.lab4saledCount.text=[NSString stringWithFormat:@"已售%@",kindModel.saledCount];
    [self.image4scenes sd_setImageWithURL:[NSURL URLWithString:kindModel.URL]];
    
    self.image4scenes.layer.cornerRadius=3;
    self.image4scenes.layer.masksToBounds=YES;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
