//
//  BookCell.h
//  DetailpageDemo
//
//  Created by Amazing on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"

@interface BookCell : UITableViewCell

//titile
@property (nonatomic,strong) UILabel * titleLabel;

//price
@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) BookModel * model;



@end
