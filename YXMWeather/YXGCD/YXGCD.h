//
//  YXGCD.h
//
//  http://home.cnblogs.com/u/YouXianMing/
//
//  Created by Y.X. on 14-4-11.
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "GCDGroup.h"
#import "GCDQueue.h"
#import "GCDSemaphore.h"
#import "GCDTimer.h"

#ifndef GCDExecOnce
#define GCDExecOnce(block) \
{ \
static dispatch_once_t predicate = 0; \
dispatch_once(&predicate, block); \
}
#endif

/**
 使用示例(仅仅执行一回,但循环4次)
 注意:这个可不是线程安全的
 
 EXECUTE_ONCE_FOR_SOME_LOOPS(4, labelName, labelName:^(int value){
 });
 */
#ifndef EXECUTE_ONCE_FOR_SOME_LOOPS
#define EXECUTE_ONCE_FOR_SOME_LOOPS(loops, label, block) \
static int label = 0;\
for(; label < loops; label++){\
block(label);\
}
#endif

