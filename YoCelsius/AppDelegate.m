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
     Lateast no warning version : Xcode 9.3 (9E145)
     QQ    705786299
     Email YouXianMing1987@126.com
     
     http://www.cnblogs.com/YouXianMing/
     https://github.com/YouXianMing
     https://github.com/YouXianMing/Animations
     https://github.com/YouXianMing/Swift-Animations
     https://github.com/YouXianMing/YoCelsius
     
     独立开发作品 (感兴趣的朋友支持一下^_^) : https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1390862464&mt=8
     */
    
    // Init window.
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    
    // Hide statusBar.
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    return YES;
}

@end
