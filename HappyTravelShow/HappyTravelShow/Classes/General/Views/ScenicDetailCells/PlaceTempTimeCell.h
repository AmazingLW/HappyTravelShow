//
//  PlaceTempTimeCell.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyModel.h"

@interface PlaceTempTimeCell : UITableViewCell

- (void)setViewWithIndex:(NSInteger)index strDetail:(NSString *)strDetail;

- (void)setViewWithObject:(SkyModel *)model;

@end
