//
//  GCDGroup.m
//
//  http://home.cnblogs.com/u/YouXianMing/
//
//  Created by Y.X. on 14-4-11.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "GCDGroup.h"

@interface GCDGroup ()
@property (STRONG, readwrite, nonatomic) dispatch_group_t dispatchGroup;
@end

@implementation GCDGroup

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

- (void)enter
{
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave
{
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait
{
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta
{
      return dispatch_group_wait(self.dispatchGroup, \
                                 dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

- (void)dispatchRelease
{
#if __has_feature(objc_arc)
#else
    dispatch_release(self.dispatchGroup);
#endif
}

@end
