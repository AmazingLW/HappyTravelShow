//
//  LocationVC.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK) (NSString*,NSString*,NSString*);
@interface LocationVC : UIViewController
@property(nonatomic,strong)BLOCK block;
@property(nonatomic,strong)BLOCK block2;
@end
