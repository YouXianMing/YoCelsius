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
#import "WeatherInfoController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     Lateast no warning version : Xcode 10.0 (10A255)
     */
    
    // Init window.
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.rootViewController = [WeatherInfoController new];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
