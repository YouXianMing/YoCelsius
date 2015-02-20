//
//  GlobalCoreData.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "GlobalCoreData.h"

@implementation GlobalCoreData

+ (void)globalInit {
    GCDGroup *group = [GCDGroup new];
    if ([@"/Documents/CityCode.sqlite" exist] == NO) {
        [[GCDQueue globalQueue] execute:^{
            NSString *srcPath = [@"CityCode.sqlite" bundleFile];
            NSString *dstPath = [@"/Documents/CityCode.sqlite" path];
            [[NSFileManager defaultManager] copyItemAtPath:srcPath
                                                    toPath:dstPath
                                                     error:nil];
        } inGroup:group];
    }
    if ([@"/Documents/CityCode.sqlite-shm" exist] == NO) {
        [[GCDQueue globalQueue] execute:^{
            NSString *srcPath = [@"CityCode.sqlite-shm" bundleFile];
            NSString *dstPath = [@"/Documents/CityCode.sqlite-shm" path];
            [[NSFileManager defaultManager] copyItemAtPath:srcPath
                                                    toPath:dstPath
                                                     error:nil];
        } inGroup:group];
    }
    if ([@"/Documents/CityCode.sqlite-wal" exist] == NO) {
        [[GCDQueue globalQueue] execute:^{
            NSString *srcPath = [@"CityCode.sqlite-wal" bundleFile];
            NSString *dstPath = [@"/Documents/CityCode.sqlite-wal" path];
            [[NSFileManager defaultManager] copyItemAtPath:srcPath
                                                    toPath:dstPath
                                                     error:nil];
        } inGroup:group];
    }
    [[GCDQueue globalQueue] notify:^{
        [MagicalRecord setupCoreDataStackWithStoreAtURL:[NSURL fileURLWithPath:[@"/Documents/CityCode.sqlite" path]]];
    } inGroup:group];
}

@end
