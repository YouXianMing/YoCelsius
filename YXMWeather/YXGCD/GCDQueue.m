//
//  GCDQueue.m
//
//  http://home.cnblogs.com/u/YouXianMing/
//
//  Created by Y.X. on 14-4-11.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "GCDQueue.h"
#import "GCDGroup.h"

static GCDQueue *mainQueue;
static GCDQueue *globalQueue;
static GCDQueue *highPriorityGlobalQueue;
static GCDQueue *lowPriorityGlobalQueue;
static GCDQueue *backgroundPriorityGlobalQueue;

@interface GCDQueue ()
@property (STRONG, readwrite, nonatomic) dispatch_queue_t dispatchQueue;
@end

@implementation GCDQueue

+ (GCDQueue *)mainQueue
{
    return mainQueue;
}

+ (GCDQueue *)globalQueue
{
    return globalQueue;
}

+ (GCDQueue *)highPriorityGlobalQueue
{
    return highPriorityGlobalQueue;
}

+ (GCDQueue *)lowPriorityGlobalQueue
{
    return lowPriorityGlobalQueue;
}

+ (GCDQueue *)backgroundPriorityGlobalQueue
{
    return backgroundPriorityGlobalQueue;
}

+ (void)initialize
{
    /**
     Initializes the class before it receives its first message.
     
     1. The runtime sends the initialize message to classes in a 
     thread-safe manner.
     
     2. initialize is invoked only once per class. If you want to 
     perform independent initialization for the class and for 
     categories of the class, you should implement load methods.
     */
    if (self == [GCDQueue self])
    {
        mainQueue = [GCDQueue new];
        mainQueue.dispatchQueue = \
            dispatch_get_main_queue();
        
        globalQueue = [GCDQueue new];
        globalQueue.dispatchQueue = \
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        highPriorityGlobalQueue = [GCDQueue new];
        highPriorityGlobalQueue.dispatchQueue = \
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        lowPriorityGlobalQueue = [GCDQueue new];
        lowPriorityGlobalQueue.dispatchQueue = \
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        
        backgroundPriorityGlobalQueue = [GCDQueue new];
        backgroundPriorityGlobalQueue.dispatchQueue = \
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

- (instancetype)init {
    return [self initSerial];
}

- (instancetype)initSerial
{
    self = [super init];
    if (self)
    {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initConcurrent
{
    self = [super init];
    if (self)
    {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)execute:(dispatch_block_t)block
{
    dispatch_async(self.dispatchQueue, block);
}

- (void)execute:(dispatch_block_t)block afterDelay:(int64_t)delta
{
    // NSEC_PER_SEC
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), self.dispatchQueue, block);
}

- (void)waitExecute:(dispatch_block_t)block
{
    /*
     As an optimization, this function invokes the block on 
     the current thread when possible.
     
     作为一个建议,这个方法尽量在当前线程池中调用.
     */
    dispatch_sync(self.dispatchQueue, block);
}

- (void)barrierExecute:(dispatch_block_t)block
{
    /*
     The queue you specify should be a concurrent queue that you 
     create yourself using the dispatch_queue_create function. 
     If the queue you pass to this function is a serial queue or 
     one of the global concurrent queues, this function behaves 
     like the dispatch_async function.
     
     使用的线程池应该是你自己创建的并发线程池.如果你传进来的参数为串行线程池
     或者是系统的并发线程池中的某一个,这个方法就会被当做一个普通的async操作
     */
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void)waitBarrierExecute:(dispatch_block_t)block
{
    /*
     The queue you specify should be a concurrent queue that you
     create yourself using the dispatch_queue_create function.
     If the queue you pass to this function is a serial queue or
     one of the global concurrent queues, this function behaves
     like the dispatch_sync function.
     
     使用的线程池应该是你自己创建的并发线程池.如果你传进来的参数为串行线程池
     或者是系统的并发线程池中的某一个,这个方法就会被当做一个普通的sync操作
     
     As an optimization, this function invokes the barrier block 
     on the current thread when possible.
     
     作为一个建议,这个方法尽量在当前线程池中调用.
     */
    
    dispatch_barrier_sync(self.dispatchQueue, block);
}

- (void)suspend
{
    dispatch_suspend(self.dispatchQueue);
}

- (void)resume
{
    dispatch_resume(self.dispatchQueue);
}

- (void)execute:(dispatch_block_t)block inGroup:(GCDGroup *)group
{
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(GCDGroup *)group
{
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}

- (void)dispatchRelease
{
#if __has_feature(objc_arc)
#else
    dispatch_release(self.dispatchQueue);
#endif
}

#pragma mark - 便利的构造方法
+ (void)executeInMainQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec
{
    [[GCDQueue mainQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec
{
    [[GCDQueue globalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec
{
    [[GCDQueue highPriorityGlobalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec
{
    [[GCDQueue lowPriorityGlobalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelaySecs:(NSTimeInterval)sec
{
    [[GCDQueue backgroundPriorityGlobalQueue] execute:^{
        block();
    } afterDelay:NSEC_PER_SEC * sec];
}

+ (void)executeInMainQueue:(dispatch_block_t)block
{
    [[GCDQueue mainQueue] execute:^{
        block();
    }];
}

+ (void)executeInGlobalQueue:(dispatch_block_t)block
{
    [[GCDQueue globalQueue] execute:^{
        block();
    }];
}

+ (void)executeInHighPriorityGlobalQueue:(dispatch_block_t)block
{
    [[GCDQueue highPriorityGlobalQueue] execute:^{
        block();
    }];
}

+ (void)executeInLowPriorityGlobalQueue:(dispatch_block_t)block
{
    [[GCDQueue lowPriorityGlobalQueue] execute:^{
        block();
    }];
}

+ (void)executeInBackgroundPriorityGlobalQueue:(dispatch_block_t)block
{
    [[GCDQueue backgroundPriorityGlobalQueue] execute:^{
        block();
    }];
}

@end
