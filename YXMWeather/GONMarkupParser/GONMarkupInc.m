//
//  GONMarkupInc.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupInc.h"

#define DEFAULT_INC_VALUE   1

@implementation GONMarkupInc
#pragma mark - Constructor
+ (instancetype)incMarkup
{
    return [super markupForTag:GONMarkupInc_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    NSInteger incValue = [[dicAttributes objectForKey:GONMarkupInc_TAG_value_ATT] intValue];
    if (!incValue)
        incValue = DEFAULT_INC_VALUE;

    // Look for current font
    UIFont *currentFont = [configurationDictionary objectForKey:NSFontAttributeName];
    if (!currentFont)
    {
        // No found defined, use default one with default size
        currentFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }

    // Update current font with new size
    [configurationDictionary setObject:[currentFont fontWithSize:currentFont.pointSize + incValue]
                                forKey:NSFontAttributeName];
}
@end