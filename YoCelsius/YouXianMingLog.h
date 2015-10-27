//
//  YouXianMingLog.h
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by YouXianMing on 15/1/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ON   1
#define OFF  0

///////////////   CONFIG   /////////////////

#define NO_LOG          OFF   // 禁用Log
#define SWITCH_LOG      OFF   // 切换打印

#define TIME_STAMP      OFF   // 时间戳
#define FILE_NAME       ON    // 文件名

////////////////////////////////////////////

#if SWITCH_LOG
#if NO_LOG
#define NSLog(args...)
#else
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#endif
#endif

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);