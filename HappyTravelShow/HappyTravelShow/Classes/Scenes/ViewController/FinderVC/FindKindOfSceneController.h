//
//  FindKindOfSceneController.h
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinderMainModel.h"

@interface FindKindOfSceneController : UIViewController

//绑定的model,用于传值
@property(nonatomic,strong) FinderMainModel  *model;
//字符串用于传值(标题)
@property(nonatomic,strong) NSString  *titleString;



@end
