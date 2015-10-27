//
//  NSString+File.m
//  Category
//
//  Created by YouXianMing on 14-8-29.
//  Copyright (c) 2014年 YouXianMing. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

- (NSString *)path
{
    return [NSHomeDirectory() stringByAppendingPathComponent:self];
}

- (NSString *)bundleFile
{
    return [[NSBundle mainBundle] pathForResource:self
                                           ofType:nil];
}

- (UIImage *)bundleImage
{
    return [UIImage imageNamed:self];
}

- (BOOL)exist
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                isDirectory:nil];
}

- (BOOL)createFolder
{
    return [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
}

- (BOOL)isDirectory
{
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                         isDirectory:&isDirectory];
    
    return isDirectory;
}

- (BOOL)copyTo:(NSString *)path
{
    return [[NSFileManager defaultManager] copyItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                   toPath:[NSHomeDirectory() stringByAppendingPathComponent:path]
                                                    error:nil];
}

- (BOOL)moveTo:(NSString *)path
{
    return [[NSFileManager defaultManager] moveItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                   toPath:[NSHomeDirectory() stringByAppendingPathComponent:path]
                                                    error:nil];
}

- (BOOL)remove
{
    return [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                      error:nil];
}

- (NSArray *)enumeratorFolder
{
    if ([self isDirectory])
    {
        NSMutableArray *storeArray = [NSMutableArray array];
        
        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:self];
        NSFileManager *localFileManager = [[NSFileManager alloc] init];
        NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
        
        NSString *file;
        while ((file = [dirEnum nextObject]))
        {
            [storeArray addObject:[[NSHomeDirectory() stringByAppendingPathComponent:self] stringByAppendingPathComponent:file]];
        }
        
        return storeArray;
    }
    else
    {
        return nil;
    }
}

- (void)enumeratorFolderEach:(void (^)(NSString *path))block
{
    if ([self isDirectory])
    {
        NSMutableArray *storeArray = [NSMutableArray array];
        
        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:self];
        NSFileManager *localFileManager = [[NSFileManager alloc] init];
        NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
        
        NSString *file;
        while ((file = [dirEnum nextObject]))
        {
            [storeArray addObject:[self stringByAppendingPathComponent:file]];
        }
        
        [storeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            block(obj);
        }];
    }
}

- (NSDictionary *)fileInfo
{
    return [[NSFileManager defaultManager] attributesOfItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                            error:nil];
}

- (int)fileSize
{
    return [[[[NSFileManager defaultManager] attributesOfItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:self]
                                                              error:nil] \
             objectForKey:@"NSFileSize"] intValue];
}

@end
