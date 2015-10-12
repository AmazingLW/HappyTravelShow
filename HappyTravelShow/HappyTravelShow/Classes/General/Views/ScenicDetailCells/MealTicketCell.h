//
//  MealTicketCell.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/11.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicDetailModel.h"

@protocol openScrollProtocal <NSObject>

- (void)openScrollEnable;

@end



typedef void(^changeBlock)(NSString *strType);
@interface MealTicketCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray * mealTicketArr;
@property (nonatomic,strong) NSMutableArray * ticketArr;
@property (nonatomic,copy) changeBlock block;
@property (nonatomic,assign) id<openScrollProtocal> delegate;



@end
