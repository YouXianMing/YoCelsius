//
//  DownloadTask.m
//  NetworkingCraft
//
//  Created by YouXianMing on 15/6/11.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "DownloadTask.h"
#import "AFNetworking.h"

@interface DownloadTask ()

@property (nonatomic, strong) AFHTTPSessionManager      *session;
@property (nonatomic, strong) NSURLSessionDownloadTask  *downloadTask;
@property (nonatomic, strong) NSString                  *file;

@end

@implementation DownloadTask

- (instancetype)init {
    self = [super init];
    if (self) {
    
        [self defaultConfig];
    }
    
    return self;
}

- (void)defaultConfig {
    self.session = [AFHTTPSessionManager manager];
}

- (void)startDownload {
    
    if (self.urlString.length <= 0) {
        return;
    }
    
    // 定义一个progress指针
    NSProgress *progress;
    
    // 创建一个URL链接
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    // 初始化一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 开始下载任务
    __weak DownloadTask *weakSelf = self;
    self.downloadTask = \
        [self.session downloadTaskWithRequest:request
                                     progress:&progress
                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                      
                                      // 获取基本路径
                                      NSString *filePath = nil;
                                      
                                      // 文件路径
                                      if (weakSelf.filePath) {
                                          filePath = [weakSelf pathWithSting:self.filePath];
                                      } else {
                                          filePath = [weakSelf pathWithSting:@"/Library/Caches"];
                                      }
                                      
                                      // 文件名字
                                      if (weakSelf.fileName) {
                                          filePath = [filePath stringByAppendingPathComponent:weakSelf.fileName];
                                      } else {
                                          filePath = [filePath stringByAppendingPathComponent:[response suggestedFilename]];
                                      }
                                      
                                      // 获取文件绝对路径
                                      weakSelf.file = filePath;
                                      
                                      NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:filePath];
                                      
                                      return documentsDirectoryURL;
                                      
                                  } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                      
                                      if (weakSelf.delegate) {
                                          // 结束后移除掉这个progress
                                          [progress removeObserver:self
                                                        forKeyPath:@"fractionCompleted"
                                                           context:nil];
                                          
                                          if (error == nil) {
                                              // 成功
                                              if ([weakSelf.delegate respondsToSelector:@selector(downloadTaskSucess:)]) {
                                                  [weakSelf.delegate downloadTaskSucess:weakSelf];
                                              }
                                          } else {
                                              // 出错
                                              if ([weakSelf.delegate respondsToSelector:@selector(downloadTask:failedWithError:)]) {
                                                  [weakSelf.delegate downloadTask:weakSelf failedWithError:error];
                                              }
                                          }
                                          
                                      }
                                  }];
    
    
    // 开始下载
    [self.downloadTask resume];
    
    if (self.delegate) {
        // 给这个progress添加监听任务
        [progress addObserver:self
                   forKeyPath:@"fractionCompleted"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    }
}

- (void)stopDownload {
    [self.downloadTask cancel];
}

/**
 *  获取路径
 *
 *  @param string 相对路径
 *
 *  @return 绝对路径
 */
- (NSString *)pathWithSting:(NSString *)string {
    return [NSHomeDirectory() stringByAppendingPathComponent:string];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        [_delegate downloadTask:self withProgress:progress.fractionCompleted];
    }
}

+ (instancetype)downloadTaskWithUrlString:(NSString *)urlString
                            fileDirectory:(NSString *)filePath
                                 fileName:(NSString *)fileName
                                 delegate:(id)delegate {
    
    DownloadTask *downloadTask = [[[self class] alloc] init];
    downloadTask.urlString     = urlString;
    downloadTask.filePath      = filePath;
    downloadTask.fileName      = fileName;
    downloadTask.delegate      = delegate;
    
    return downloadTask;
}

@end
