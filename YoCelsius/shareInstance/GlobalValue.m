//
//  GlobalValue.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "GlobalValue.h"

@implementation GlobalValue

@synthesize haveCopiedDataBase = _haveCopiedDataBase;
- (void)setHaveCopiedDataBase:(BOOL)haveCopiedDataBase {
    [[NSUserDefaults standardUserDefaults] setObject:@(haveCopiedDataBase)
                                              forKey:@"haveCopiedDataBase"];
}
- (BOOL)haveCopiedDataBase {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"haveCopiedDataBase"] boolValue];
}

@end
