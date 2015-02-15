//
//  GONMarkupLineStyle.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 03/02/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupLineStyle.h"
#import "NSString+Color.h"

@interface GONMarkupLineStyle ()
// Data
@property (nonatomic, strong) NSString *configurationKey;
@property (nonatomic, strong) NSString *colorConfigurationKey;
@end

@implementation GONMarkupLineStyle
#pragma mark - Class initialization
static NSDictionary *dicStyles;
static NSDictionary *dicPatterns;
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dicStyles = @{
                        @"single" : @(NSUnderlineStyleSingle),
                        @"double" : @(NSUnderlineStyleDouble),
                        @"thick"  : @(NSUnderlineStyleThick),
                     };

        dicPatterns = @{
                         @"solid"       : @(NSUnderlinePatternSolid),
                         @"dot"         : @(NSUnderlinePatternDot),
                         @"dash"        : @(NSUnderlinePatternDash),
                         @"dashdot"     : @(NSUnderlinePatternDashDot),
                         @"dashdotdot"  : @(NSUnderlinePatternDashDotDot)
                       };
    });
}

#pragma mark - Constructor
+ (NSArray *)allMarkups
{
    return @[[self underlineMarkup], [self strikethroughMarkup]];
}

+ (instancetype)underlineMarkup
{
    GONMarkupLineStyle *markup = [self markupForTag:GONMarkupLineStyle_Underline_TAG];

    markup.configurationKey      = NSUnderlineStyleAttributeName;
    markup.colorConfigurationKey = NSUnderlineColorAttributeName;

    return markup;
}

+ (instancetype)strikethroughMarkup
{
    GONMarkupLineStyle *markup = [self markupForTag:GONMarkupLineStyle_Strikethrough_TAG];

    markup.configurationKey      = NSStrikethroughStyleAttributeName;
    markup.colorConfigurationKey = NSStrikethroughColorAttributeName;

    return markup;
}

#pragma mark - Markup lifecycle
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Hold new configuration
    [configurationDictionary setObject:@([self extractStyleFromAttributes:dicAttributes])
                                forKey:_configurationKey];
    
    // Color
    UIColor *color = [[dicAttributes objectForKey:GONMarkupLineStyle_TAG_color_ATT] representedColor];
    if (color)
    {
        [configurationDictionary setObject:color
                                    forKey:_colorConfigurationKey];
    }
}

- (NSInteger)extractStyleFromAttributes:(NSDictionary *)dicAttributes
{
    NSNumber *tmp;
    NSInteger style = 0;

    // Word option
    if ([[dicAttributes objectForKey:GONMarkupLineStyle_TAG_word_ATT] boolValue])
        style |= NSUnderlineByWord;

    // Style option
    tmp = [dicStyles objectForKey:[[dicAttributes objectForKey:GONMarkupLineStyle_TAG_style_ATT] lowercaseString]];
    if (tmp)
        style |= [tmp integerValue];
    else
        style |= NSUnderlineStyleSingle;

    // Pattern option
    tmp = [dicPatterns objectForKey:[[dicAttributes objectForKey:GONMarkupLineStyle_TAG_pattern_ATT] lowercaseString]];
    if (tmp)
        style |= [tmp integerValue];
    else
        style |= NSUnderlinePatternSolid;

    return style;
}
@end