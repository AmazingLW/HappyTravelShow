//
//  CommonCells.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinderKindModel.h"

@interface CommonCells : UITableViewCell
@property(nonatomic,strong) FinderKindModel  *kindModel;


@property (weak, nonatomic) IBOutlet UIImageView *image4scenes;
@property (weak, nonatomic) IBOutlet UILabel *lab4productName;
@property (weak, nonatomic) IBOutlet UILabel *lab4productTitleContent;
@property (weak, nonatomic) IBOutlet UILabel *lab4originalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab4price;
@property (weak, nonatomic) IBOutlet UILabel *lab4saledCount;
@property (weak, nonatomic) IBOutlet UILabel *cityName;

@end
