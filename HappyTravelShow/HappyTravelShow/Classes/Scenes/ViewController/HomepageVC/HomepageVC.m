//
//  HomepageVC.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "HomepageVC.h"
#import "HomepageHelper.h"

@interface HomepageVC ()

@end

@implementation HomepageVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *image = [UIImage imageNamed:@"homepage"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image tag:1001];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HomepageHelper shareHelp] requestAllPackageWithFinish:^{
        NSLog(@"_%@",[HomepageHelper shareHelp].CarouseArray);
    }];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
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
