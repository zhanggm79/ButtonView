//
//  AppDelegate.m
//  ButtonView
//
//  Created by Z on 2017/9/15.
//  Copyright © 2017年 Z. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    ViewController * Ctrl = [[ViewController alloc] init];
    UINavigationController * navCtrl = [[UINavigationController alloc] initWithRootViewController:Ctrl];
    //UINavigationBar底部的颜色设置成
    [navCtrl.navigationBar setBarTintColor:GM_RGBColor(48, 50, 57)];
    [navCtrl.navigationBar setTintColor:[UIColor whiteColor]];
    //文字颜色设置
    [navCtrl.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置状态栏字体颜色为白色
    navCtrl.navigationBar.barStyle = UIBarStyleBlack;
    //半透明状态设置为NO
    [navCtrl.navigationBar setTranslucent:NO];

    self.window.rootViewController = navCtrl;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
