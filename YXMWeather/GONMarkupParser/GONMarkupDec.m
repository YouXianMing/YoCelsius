//
//  GONMarkupDec.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupDec.h"

#define DEFAULT_DEC_VALUE   1

@implementation GONMarkupDec
#pragma mark - Constructor
+ (instancetype)decMarkup
{
    return [super markupForTag:GONMarkupDec_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    NSInteger incValue = [[dicAttributes objectForKey:GONMarkupDec_TAG_value_ATT] intValue];
    if (!incValue)
        incValue = DEFAULT_DEC_VALUE;

    // Look for current font
    UIFont *currentFont = [configurationDictionary objectForKey:NSFontAttributeName];
    if (!currentFont)
    {
        // No found defined, use default one with default size
        currentFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }

    // Update current font with new size
    [configurationDictionary setObject:[currentFont fontWithSize:MAX(currentFont.pointSize - incValue, 1)]
                                forKey:NSFontAttributeName];
}
@end