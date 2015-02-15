//
//  GONMarkupReset.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupReset.h"
#import "GONMarkup+Private.h"

@implementation GONMarkupReset
#pragma mark - Constructor
+ (instancetype)resetMarkup
{
    return [self markupForTag:GONMarkupReset_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Reset configuration
    [configurationDictionary removeAllObjects];

    // Set it back to default if allowed
    if (![[dicAttributes objectForKey:GONMarkupReset_TAG_all_ATT] boolValue])
        [configurationDictionary addEntriesFromDictionary:self.parser.defaultConfiguration];

    // Copy current context
    NSMutableDictionary *contextCopy = [context mutableCopy];

    // Reset it
    [context removeAllObjects];

    // Hold saved context
    [context setObject:contextCopy
                 forKey:GONMarkupReset_SAVED_CONTEXT_KEY];
}

- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Copy current context
    NSMutableDictionary *savedContext = [context objectForKey:GONMarkupReset_SAVED_CONTEXT_KEY];

    // Reset context
    [context removeAllObjects];

    // Reset current context to previously saved one
    [context addEntriesFromDictionary:savedContext];
}
@end
