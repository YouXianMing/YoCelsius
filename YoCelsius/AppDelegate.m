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
    
    /*
     
     请用真机测试
     最新编译无警告版本 Xcode Version 7.3.1 (7D1014)
     
     QQ   705786299
     邮箱  YouXianMing1987@126.com
     博客  http://www.cnblogs.com/YouXianMing/
     源码  https://github.com/YouXianMing
     项目  https://github.com/YouXianMing/Animations
     
     苹果下载地址： https://itunes.apple.com/us/app/yocelsius/id967721892?l=zh&ls=1&mt=8 给个好评吧 :)
     本人讲解视频： http://my.jikexueyuan.com/YouXianMing/record/
     
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

@end
