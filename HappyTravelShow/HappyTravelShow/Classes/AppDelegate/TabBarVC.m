//
//  TabBarVC.m
//  HappyTravelShow
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "TabBarVC.h"
#import "HomepageVC.h"
#import "AroundVC2.h"
#import "FinderVC.h"
#import "MyselfVC.h"


@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //周边页
    UINavigationController *AroundNV = [[UINavigationController alloc] initWithRootViewController:[AroundVC2 new]];
    
    
    //首页
    UINavigationController *HomepageNV = [[UINavigationController alloc] initWithRootViewController:[HomepageVC new]];
    
    
    
    //发现页
    UINavigationController *FinderNV = [[UINavigationController alloc] initWithRootViewController:[FinderVC new]];
    
    
    //我的
    UINavigationController *MyselfNV = [[UINavigationController alloc] initWithRootViewController:[MyselfVC new]];
    
    
    //创建tabbar
    self.viewControllers = @[HomepageNV,AroundNV,FinderNV,MyselfNV];
    self.tabBar.tintColor = [UIColor orangeColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
