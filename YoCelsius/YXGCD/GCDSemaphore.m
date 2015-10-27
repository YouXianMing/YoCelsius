//
//  GCDSemaphore.m
//
//  http://home.cnblogs.com/u/YouXianMing/
//
//  Created by Y.X. on 14-4-11.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//
#import "GCDSemaphore.h"

@interface GCDSemaphore ()

@property (STRONG, readwrite, nonatomic) dispatch_semaphore_t dispatchSemaphore;

@end

@implementation GCDSemaphore

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.dispatchSemaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (instancetype)initWithValue:(long)value
{
    self = [super init];
    if (self)
    {
        self.dispatchSemaphore = dispatch_semaphore_create(value);
    }
    return self;
}

- (BOOL)signal
{
    return dispatch_semaphore_signal(self.dispatchSemaphore) != 0;
}

- (void)wait
{
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta
{
      return dispatch_semaphore_wait(self.dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

- (void)dispatchRelease
{
#if __has_feature(objc_arc)
#else
    dispatch_release(self.dispatchSemaphore);
#endif
}

@end
