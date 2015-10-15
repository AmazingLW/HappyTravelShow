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
@dynamic aamodel;
- (void)setModel:(AroundKindModel *)Model{
    
    self.lab4productName.text=Model.productName;
    self.lab4productTitleContent.text=Model.productTitleContent;
    self.lab4productTitleContent.numberOfLines=0;
    self.cityName.text=[NSString stringWithFormat:@"[%@]",Model.cityName];
    self.lab4price.text=[NSString stringWithFormat:@"%ld",Model.price];
    //横线
//    LPLabel *lp = [[LPLabel alloc] initWithFrame:CGRectMake(236, 100, 34, 21)];
//    lp.text = [NSString stringWithFormat:@"%ld",Model.originalPrice];
//    [self addSubview:lp];
 //   self.lab4originalPrice = lp;
    
    self.lab4originalPrice.text=[NSString stringWithFormat:@"%ld",Model.originalPrice];
    self.lab4saledCount.text=[NSString stringWithFormat:@"已售%ld",Model.saledCount];
    [self.image4scenes sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",Model.url]]];
    
}

- (void)setAamodel:(HotSearchModel *)aamodel{
    
    self.lab4productName.text=aamodel.appMainTitle;
    self.lab4productTitleContent.text=aamodel.appSubTitle;
    self.lab4productTitleContent.numberOfLines=0;
    self.cityName.text=[NSString stringWithFormat:@"[%@]",aamodel.city];
    self.lab4price.text=[NSString stringWithFormat:@"%ld",aamodel.price];
    //横线
    //    LPLabel *lp = [[LPLabel alloc] initWithFrame:CGRectMake(236, 100, 34, 21)];
    //    lp.text = [NSString stringWithFormat:@"%ld",Model.originalPrice];
    //    [self addSubview:lp];
    //   self.lab4originalPrice = lp;
    
    self.lab4originalPrice.text=[NSString stringWithFormat:@"%ld",aamodel.retailPrice];
    self.lab4saledCount.text=[NSString stringWithFormat:@"已售%ld",aamodel.saledCount];
    [self.image4scenes sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn1.jinxidao.com/%@",aamodel.appImageUrl]]];
}

@end
