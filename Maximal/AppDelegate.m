//
//  AppDelegate.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "AppDelegate.h"

#import "LhyMainViewController.h"
#import "LhyBaseNavigationController.h"
#import "LhyHotPotViewController.h"
#import "LhyEnjoyViewController.h"
#import "LhyCommunityViewController.h"
#import "ConfigurationTheme.h"
#import "LhyGuidePageViewController.h"
#import "UMSocial.h"



@interface AppDelegate ()


@property(nonatomic, retain)UIColor *defaultColor;

@end

@implementation AppDelegate

- (void)dealloc {
    
    [_tb release];
    [_defaultColor release];
    [_window release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     * 创建四个界面的导航控制器和VC
     */
    
    /* 友盟 */
    [UMSocialData setAppKey:@"5654440ae0f55a1949000ef2"];
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主VC, 即订阅界面 */
    LhyMainViewController *mainVC = [LhyMainViewController sharedMainVC];
    LhyBaseNavigationController *mainNavi = [[LhyBaseNavigationController alloc] initWithRootViewController:mainVC];
    
    /* 热点界面 */
    LhyHotPotViewController *hotpotVC = [[LhyHotPotViewController alloc] init];
    LhyBaseNavigationController *hotpotNavi = [[LhyBaseNavigationController alloc] initWithRootViewController:hotpotVC];
    
    /* 玩乐界面 */
    LhyEnjoyViewController *enjoyVC = [LhyEnjoyViewController sharedEnjoyVC];
    LhyBaseNavigationController *enjoyNavi = [[LhyBaseNavigationController alloc] initWithRootViewController:enjoyVC];
    
    
    /* 社区界面 */
    LhyCommunityViewController *communityVC = [LhyCommunityViewController sharedMainVC];
    LhyBaseNavigationController *communityNavi = [[LhyBaseNavigationController alloc] initWithRootViewController:communityVC];
    
    /**
     *  设置tabBar
     */
    self.tb = [[UITabBarController alloc] init];
    self.tb.viewControllers = @[mainNavi, hotpotNavi, enjoyNavi, communityNavi];
    
    if ([readStr isEqualToString:@"YES"]) {
        self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarNewColor"];
//        self.tb.tabBar.tintColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarItemNewColor"];
        self.tb.tabBar.tintColor = [UIColor colorWithWhite:0.871 alpha:1.000];
    
        
    } else {
        
        self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarDefaultColor"];
        self.tb.tabBar.tintColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarItemDefaultColor"];
    }
    
    
    self.tb.tabBar.barTintColor = self.defaultColor;
    
    /* 用消息中心, 控制tabbar的出现和隐藏 */
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(handleHideTabbar) name:@"hideTabbar" object:nil];
    
    [center addObserver:self selector:@selector(handleShowTabbar) name:@"showTabbar" object:nil];
    
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];

    
    /* 订阅 */
    mainNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"订阅" image:[UIImage imageNamed:@"DashboardTabBarItemSubscription"] tag:100];
    [mainNavi.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    /* 热点 */
    hotpotVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热点" image:[UIImage imageNamed:@"DashboardTabBarItemDailyHot"] tag:200];
    [hotpotNavi.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    /* 玩乐 */
    enjoyNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"玩乐" image:[UIImage imageNamed:@"DashboardTabbarLife"] tag:300];
    [enjoyNavi.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    /* 社区 */
    communityNavi.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"社区" image:[UIImage imageNamed:@"DashboardTabBarItemDiscussion"] tag:400];
    [communityNavi.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    
    
    LhyGuidePageViewController *guidePageVC = [LhyGuidePageViewController sharedGuideVC];
    
    self.window.rootViewController = guidePageVC;
 
    [hotpotNavi release];
    [hotpotVC release];
    [enjoyNavi release];
    [enjoyVC release];
    [communityNavi release];
    [communityVC release];
    [mainNavi release];
    [mainVC release];
    [self.tb release];
    return YES;
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.tb.tabBar.barTintColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarNewColor"];
        self.tb.tabBar.tintColor = [UIColor colorWithWhite:0.871 alpha:1.000];
        
        
    } else {

        self.tb.tabBar.barTintColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarDefaultColor"];
        
        self.tb.tabBar.tintColor= [[ConfigurationTheme shareInstance] getThemeColorWithName:@"tabBarItemDefaultColor"];
    }
    
    
}

/* 隐藏tabbar方法 */
- (void)handleHideTabbar {
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.tb.tabBar.frame = CGRectMake(-self.window.frame.size.width, self.window.frame.size.height - 50, self.window.frame.size.width, 50);
        
    }];
    
}
/* 显示tabbar方法 */
- (void)handleShowTabbar {
    
    [UIView animateWithDuration:0.31 animations:^{
        
        self.tb.tabBar.frame = CGRectMake(0, self.window.frame.size.height - 49, self.window.frame.size.width, 50);
        
    }];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
