//
//  CommonCells+SetModel.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "CommonCells+SetModel.h"
#import "UIImageView+WebCache.h"
#import "LPLabel.h"
@implementation CommonCells (SetModel)
@dynamic Model;
- (void)setModel:(AroundKindModel *)Model{
    
    self.lab4productName.text=Model.productName;
    self.lab4productTitleContent.text=Model.productTitleContent;
    self.lab4productTitleContent.numberOfLines=0;
    self.cityName.text=[NSString stringWithFormat:@"[%@]",Model.cityName];
    self.lab4price.text=[NSString stringWithFormat:@"%ld",Model.price];
    
//    LPLabel *lp = [[LPLabel alloc] init];
//    lp.text = [NSString stringWithFormat:@"%ld",kindModel.originalPrice];
//    self.lab4originalPrice = lp;
    self.lab4originalPrice.text=[NSString stringWithFormat:@"%ld",Model.originalPrice];
    self.lab4saledCount.text=[NSString stringWithFormat:@"已售%ld",Model.saledCount];
    [self.image4scenes sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",Model.url]]];
    
}
@end
