//
//  AppDelegate.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/15.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 支持作者 (大家都是做开发的，知道开发应用的辛酸，如果用了该源码学习，请用你的手机打开以下网址，去appStore下载安装，然后给个好评，您的支持是作者继续开源代码的动力)
    
    /*
       = 作者联系方式 =
        
       ------------------------------------------
       QQ   705786299
       邮箱  you_xian_1030@163.com
       博客  http://www.cnblogs.com/YouXianMing/
       Git  https://github.com/YouXianMing
       ------------------------------------------
     
       苹果下载地址： https://itunes.apple.com/us/app/yocelsius/id967721892?l=zh&ls=1&mt=8
       本人讲解视频： http://www.cnblogs.com/YouXianMing/p/4608526.html
     
       = 注意 =
     
       1. 请用真机测试
       2. 最新编译无警告版本 Xcode Version 7.1 (7B91b)
     */
    
    // 初始化
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    return YES;
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
