//
//  GONMarkupNamedColor.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupNamedColor.h"
#import "GONMarkup+Private.h"

@interface GONMarkupNamedColor ()
// Data
@property (nonatomic, strong) UIColor *color;
@end

@implementation GONMarkupNamedColor
#pragma mark - Class constructor
+ (instancetype)namedColorMarkup:(UIColor *)aColor forTag:(NSString *)tag
{
    GONMarkupNamedColor *markup = [self markupForTag:tag];

    markup.color = aColor;

    return markup;
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_color)
    {
        [configurationDictionary setObject:_color
                                     forKey:NSForegroundColorAttributeName];
    }
    else
    {
        UIColor *defaultColor = [[self.parser defaultConfiguration] objectForKey:NSForegroundColorAttributeName];
        if (defaultColor)
        {
            [configurationDictionary setObject:defaultColor
                                         forKey:NSForegroundColorAttributeName];
        }
        else
        {
            [configurationDictionary removeObjectForKey:NSForegroundColorAttributeName];
        }
    }
}

@end
