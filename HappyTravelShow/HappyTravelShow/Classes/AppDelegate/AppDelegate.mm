//
//  AppDelegate.m
//  HappyTravelShow
//
//  Created by Amazing on 15/10/6.
//  Copyright (c) 2015年 com.liuwei. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "SController.h"
#import "TabBarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //引导图
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:@"aa"]) {
        NSLog(@"第一次启动"); //进入说明是第一次启动
        SController *guideFigureVC=[SController new];
        
        //把根视图控制器赋予它
        self.window.rootViewController =guideFigureVC;
        [self.window makeKeyAndVisible];
    }else{
        
        self.window.rootViewController = [TabBarVC new];

        
        [self.window makeKeyAndVisible];
        
    }

    
    
    
    
    
    
    
    
        [UMSocialData setAppKey:@"561dd14067e58e135400590f"];
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];

    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"OlNuoDXPk6XiEjIGqpA9rBMh"  generalDelegate:nil];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"百度SDK加载成功----");
    }
    
    //加载LeanCloud sdk----------
    [AVOSCloud setApplicationId:@"QwqfqtxhKuQRaoqxSPig3cu8"
                      clientKey:@"3aCIY3mApCj2T4of6JJTJkGy"];


    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
