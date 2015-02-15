//
//  GONMarkupLineBreak.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupLineBreak.h"
#import "GONMarkupList.h"

#define NEW_LINE            @"\n"
#define CARRIAGE_RETURN     @"\u2028"

@implementation GONMarkupLineBreak
#pragma mark - Constructor
+ (instancetype)lineBreakMarkup
{
    return [self markupForTag:GONMarkupLineBreak_TAG];
}

#pragma mark - Content update
- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // If in a list, no new lines
    if ([context objectForKey:GONMarkupList_CONFIGURATIONS_KEY])
        return CARRIAGE_RETURN;

    return NEW_LINE;
}

@end
