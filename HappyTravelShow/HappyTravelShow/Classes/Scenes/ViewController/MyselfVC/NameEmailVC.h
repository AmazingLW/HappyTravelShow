//
//  NameEmailVC.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/13.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ChangeBLOCK)(NSString *changeContent);

@interface NameEmailVC : UIViewController

@property (nonatomic,assign) BOOL isChangeName;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * email;

@property (nonatomic,copy) ChangeBLOCK changeBlock;


@end
