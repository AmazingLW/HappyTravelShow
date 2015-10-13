//
//  GPSCell.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK) (NSString*,NSString*,NSString*);
@interface GPSCell : UITableViewCell
@property(nonatomic,strong)UICollectionView*collection;
@property(nonatomic,strong)BLOCK block;

@end
