//
//  HotScenicCell.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotScenicCell;

@protocol CityDelegate <NSObject>

- (void)getDetailControllerB9;
- (void)getDetailControllerB10;
- (void)getDetailControllerB11;
- (void)getDetailControllerB12;
- (void)getDetailControllerB13;
- (void)getDetailControllerB14;
- (void)getDetailControllerB15;
- (void)getDetailControllerB16;

@end


@interface HotScenicCell : UICollectionViewCell
@property(nonatomic,strong)UIView*view;


@property(nonatomic,strong)UIButton*b1,*b2,*b3,*b4,*b5,*b6,*b7,*b8,*b9,*b10,*b11,*b12,*b13,*b14,*b15,*b16;

@property(nonatomic,strong) id <CityDelegate> delegate;
@end
