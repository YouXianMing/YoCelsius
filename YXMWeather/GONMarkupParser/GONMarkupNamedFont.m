//
//  GONMarkupNamedFont.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupNamedFont.h"
#import "GONMarkup+Private.h"

@interface GONMarkupNamedFont ()
// Data
@property (nonatomic, strong) UIFont *font;
@end

@implementation GONMarkupNamedFont
#pragma mark - Class constructor
+ (instancetype)namedFontMarkup:(UIFont *)font forTag:(NSString *)tag
{
    GONMarkupNamedFont *markup = [self markupForTag:tag];

    markup.font = font;
    
    return markup;
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_font)
    {
        [configurationDictionary setObject:_font
                                     forKey:NSFontAttributeName];
    }
    else
    {
        UIFont *defaultfont = [[self.parser defaultConfiguration] objectForKey:NSFontAttributeName];
        if (defaultfont)
        {
            [configurationDictionary setObject:defaultfont
                                         forKey:NSFontAttributeName];
        }
        else
        {
            [configurationDictionary removeObjectForKey:NSFontAttributeName];
        }
    }
}
@end
