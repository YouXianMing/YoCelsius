//
//  GONMarkupColor.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONMarkupColor.h"
#import "NSString+Color.h"

@implementation GONMarkupColor
#pragma mark - Constructor
+ (instancetype)colorMarkup
{
    return [self markupForTag:GONMarkupColor_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    UIColor *colorValue = [[dicAttributes objectForKey:GONMarkupColor_TAG_value_ATT] representedColor];
    if (colorValue)
    {
        [configurationDictionary setObject:colorValue
                                     forKey:NSForegroundColorAttributeName];
    }
}

@end
