//
//  GlobalValue.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
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
