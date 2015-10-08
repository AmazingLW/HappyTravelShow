//
//  RecommendationCell.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "RecommendationCell.h"

@implementation RecommendationCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setPackage:(HomepagePackageModel *)package{
    
    self.Product4lable.text = [NSString stringWithFormat:@"%@ - %@",package.productName,package.productTitleContent];
    self.labelText4lable.text = package.labelText;
    self.price4lable.text = [NSString stringWithFormat:@"￥%ld",package.price];
    self.original4image.text =[NSString stringWithFormat:@"￥%ld",package.originalPrice];
    self.saled4lable.text =[NSString stringWithFormat:@"已售%ld",package.saledCount];
    
}

@end
