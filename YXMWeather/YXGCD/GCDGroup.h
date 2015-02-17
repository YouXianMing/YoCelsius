//
//  GCDGroup.h
//
//  http://home.cnblogs.com/u/YouXianMing/
//
//  Created by Y.X. on 14-4-11.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#define STRONG strong
#else
#define STRONG retain
#endif

@interface GCDGroup : NSObject

@property (STRONG, readonly, nonatomic) dispatch_group_t dispatchGroup;

#pragma 初始化以及释放
- (instancetype)init;
- (void)dispatchRelease;

#pragma 用法
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
