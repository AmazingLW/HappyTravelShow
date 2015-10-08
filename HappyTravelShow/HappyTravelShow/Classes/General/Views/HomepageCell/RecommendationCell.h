//
//  RecommendationCell.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomepagePackageModel.h"

@interface RecommendationCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bigUrl4image;
@property (weak, nonatomic) IBOutlet UILabel *Product4lable;
@property (weak, nonatomic) IBOutlet UILabel *price4lable;
@property (weak, nonatomic) IBOutlet UILabel *original4image;
@property (weak, nonatomic) IBOutlet UILabel *saled4lable;
@property (weak, nonatomic) IBOutlet UILabel *labelText4lable;
@property (weak, nonatomic) IBOutlet UILabel *city4lable;
@property (nonatomic,strong)HomepagePackageModel*package;
@end
