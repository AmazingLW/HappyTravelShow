//
//  FindMainDetaiCell.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinderMainModel.h"


@interface FindMainDetaiCell : UITableViewCell

@property(nonatomic,strong) FinderMainModel  *mainModel;


@property(nonatomic,strong) UIImageView  *imgView;
//定位图片
@property(nonatomic,strong) UIImageView  *locationView;
@property(nonatomic,strong) UILabel  *lab4subTitle;
@property(nonatomic,strong) UILabel *lab4numdescription;
@property(nonatomic,strong) UILabel *lab4cityName;



@end
