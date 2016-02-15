//
//  YouXianMingLog.m
//
//  http://home.cnblogs.com/u/YouXianMing/
//  https://github.com/YouXianMing
//
//  Created by YouXianMing on 15/1/3.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "YouXianMingLog.h"

#ifndef GCDExecOnce
#define GCDExecOnce(block) \
{ \
static dispatch_once_t predicate = 0; \
dispatch_once(&predicate, block); \
}
#endif

#define DMDEBUG_DEFAULT_DATEFORMAT @"HH:mm:ss.SSS"

static NSDateFormatter* _DMLogDateFormatter = nil;

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...) {
    
    // 获取时间格式
    GCDExecOnce(^{
        
        _DMLogDateFormatter = [[NSDateFormatter alloc] init];
        [_DMLogDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [_DMLogDateFormatter setDateFormat:DMDEBUG_DEFAULT_DATEFORMAT];
    });
    
#if TIME_STAMP
    // 获取当前时间戳
    const char *nowCString = [[_DMLogDateFormatter stringFromDate:[NSDate date]] cStringUsingEncoding:NSUTF8StringEncoding];
    
    // 处理format
    va_list ap;
    va_start (ap, format);
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    
#if FILE_NAME
    
    // 获取一些参数
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    
    // 打印
    fprintf(stderr, "%s %s:%d %s", nowCString, [fileName UTF8String], lineNumber, [body UTF8String]);
    
#else
    
    fprintf(stderr, "%s %s", nowCString, [body UTF8String]);
    
#endif
    
#else
    // 处理format
    va_list ap;
    va_start (ap, format);
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    
    
    
#if FILE_NAME
    
    // 获取一些参数
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    
    // 打印
    fprintf(stderr, "%s:%d %s", [fileName UTF8String], lineNumber, [body UTF8String]);
    
#else
    
    fprintf(stderr, "%s", [body UTF8String]);
    
#endif
    
#endif
}