//
//  GenderBirthVC.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/14.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BirthAndGenderBlock)(NSString *strDate);

@interface GenderBirthVC : UIViewController

@property (nonatomic,copy) BirthAndGenderBlock birthandGenderBlock;

@property (nonatomic,assign) BOOL isFemale;
@property (nonatomic,strong) NSString * strGender;

- (void) drawGenderView;
- (void) drawBirthView;


@end
