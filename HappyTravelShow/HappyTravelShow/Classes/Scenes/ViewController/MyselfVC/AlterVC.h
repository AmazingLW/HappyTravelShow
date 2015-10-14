//
//  AlterVC.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AreaBlock)(NSString *strArea);

@interface AlterVC : UIViewController

@property (nonatomic,copy) AreaBlock areaBlock;

- (void)touchCell;

@end
