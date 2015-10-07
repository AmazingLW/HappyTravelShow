//
//  FinderMainCell.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinderMainModel.h"


@interface FinderMainCell : UITableViewCell
@property(nonatomic,strong) FinderMainModel  *mainModel;
@property (weak, nonatomic) IBOutlet UILabel *lab4title;
@property (weak, nonatomic) IBOutlet UILabel *lab4subTitle;
@property (weak, nonatomic) IBOutlet UIImageView *FinderMain4imageView;
@property (weak, nonatomic) IBOutlet UILabel *lab4location;

@property (weak, nonatomic) IBOutlet UIView *view;


@end
