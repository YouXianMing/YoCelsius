//
//  GONMarkup+Private.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkup+Private.h"

@implementation GONMarkup (Private)
#pragma mark - LIFO shared context management
- (void)pushConfiguration:(id)configuration toContext:(NSMutableDictionary *)context forKey:(NSString *)key
{
    // Retrieve FIFO
    NSMutableArray *configurationsLIFO = [context objectForKey:key];
    if (!configurationsLIFO)
    {
        // Create FIFO
        configurationsLIFO = [[NSMutableArray alloc] init];
        [context setObject:configurationsLIFO
                    forKey:key];
    }

    // Hold current configuration
    [configurationsLIFO addObject:configuration];
}

- (id)currentContextConfiguration:(NSString *)key fromContext:(NSMutableDictionary *)context
{
    return [[context objectForKey:key] lastObject];
}

- (id)popContextConfiguration:(NSString *)key fromContext:(NSMutableDictionary *)context
{
    // Retrieve LIFO
    NSMutableArray *configurationsLIFO = [context objectForKey:key];

    // Retrieve current configuration
    id currentConfiguration = [configurationsLIFO lastObject];

    // Remove last configuration
    [configurationsLIFO removeLastObject];

    // Check if list is empty
    if (!configurationsLIFO.count)
    {
        // Remove empty list
        [context removeObjectForKey:key];
    }

    return currentConfiguration;
}

@dynamic parser;
@end