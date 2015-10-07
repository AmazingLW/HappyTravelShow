//
//  HomepageHelper.h
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomepageHelper : NSObject
+(HomepageHelper*)shareHelp;

@property(nonatomic,strong)NSArray*CarouseArray;
@property(nonatomic,strong)NSArray*ProductArray;
@property(nonatomic,strong)NSArray*PackageArray;
- (void)requestAllPackageWithFinish:(void (^)())result;
@end