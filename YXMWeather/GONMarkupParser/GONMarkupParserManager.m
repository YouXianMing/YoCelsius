//
//  GONMarkupParserManager.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/07/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupParserManager.h"
#import "GONMarkupDefaultMarkups.h"

@interface GONMarkupParserManager ()
// Data
@property (nonatomic, strong) NSMutableDictionary *registeredParsers;
@end

@implementation GONMarkupParserManager
#pragma mark - Shared manager
+ (instancetype)manager
{
    static GONMarkupParserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        _registeredParsers = [[NSMutableDictionary alloc] init];
    }

    return self;
}

#pragma mark - Shared instance
+ (GONMarkupParser *)sharedParser
{
    static GONMarkupParser *sharedParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [GONMarkupParser defaultMarkupParser];
    });

    return sharedParser;
}

+ (GONMarkupParser *)registeredMarkupParserForKey:(NSString *)key
{
    return [[[self manager] registeredParsers] objectForKey:key];
}

+ (void)registerMarkupParser:(GONMarkupParser *)parser forKey:(NSString *)key
{
    [[[self manager] registeredParsers] setObject:parser
                                           forKey:key];
}

+ (void)unregisterMarkupParserForKey:(NSString *)key
{
    [[[self manager] registeredParsers] removeObjectForKey:key];
}

@end
