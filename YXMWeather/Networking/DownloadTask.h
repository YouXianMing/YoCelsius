//
//  DownloadTask.h
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DownloadTask;

@protocol DownloadTaskDelegate <NSObject>
@optional
/**
 *  下载任务
 *
 *  @param downloadTask 实例对象
 *  @param progress     进度显示
 */
- (void)downloadTask:(DownloadTask *)downloadTask withProgress:(CGFloat)progress;

/**
 *  下载失败
 *
 *  @param downloadTask 实例对象
 *  @param error        错误信息
 */
- (void)downloadTask:(DownloadTask *)downloadTask failedWithError:(NSError *)error;

/**
 *  下载成功
 *
 *  @param downloadTask 实例对象
 */
- (void)downloadTaskSucess:(DownloadTask *)downloadTask;

@end

@interface DownloadTask : NSObject

/**
 *  代理
 */
@property (nonatomic, weak) id <DownloadTaskDelegate>    delegate;

/**
 *  标识符
 */
@property (nonatomic, strong) NSString                  *flag;

/**
 *  下载地址
 */
@property (nonatomic, strong) NSString                  *urlString;

/**
 *  存储的文件路径（不包括文件名字，如果不设置，则默认在/Library/Caches文件夹下）
 *
 *  --------------------
 *  /Documents
 *  /Library/Caches
 *  /Library/Preferences
 *  /tmp
 *  --------------------
 *
 */
@property (nonatomic, strong) NSString                  *filePath;

/**
 *  文件名（如果不给文件名，则使用默认的文件名）
 */
@property (nonatomic, strong) NSString                  *fileName;

/**
 *  绝对文件路径
 */
@property (nonatomic, strong, readonly) NSString        *file;

/**
 *  开始下载
 */
- (void)startDownload;

/**
 *  停止下载
 */
- (void)stopDownload;

#pragma mark - 便利构造器
/**
 *  便利构造器
 *
 *  @param urlString 下载地址
 *  @param filePath  文件相对目录（可以不设置）
 *  @param fileName  文件名字（可以不设置）
 *  @param delegate  代理对象
 *
 *  @return 实例对象
 */
+ (instancetype)downloadTaskWithUrlString:(NSString *)urlString
                            fileDirectory:(NSString *)filePath
                                 fileName:(NSString *)fileName
                                 delegate:(id)delegate;

@end
