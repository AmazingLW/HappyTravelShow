//
//  SDHeaderCell.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/10.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareBlock)();

@protocol BackandShareProtocal <NSObject>

- (void)backToHomepage;


@end


@interface SDHeaderCell : UITableViewCell

@property(nonatomic,copy) ShareBlock  shareBlock;

@property (nonatomic,assign) id<BackandShareProtocal> delegate;

- (void)setViewWithTitle:(NSString *)strTitle coverPic:(NSString *)coverPic;

@end
