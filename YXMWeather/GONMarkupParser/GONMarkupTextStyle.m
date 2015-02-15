//
//  GONMarkupTextStyle.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/07/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupTextStyle.h"
#import <CoreText/CoreText.h>

@interface GONMarkupTextStyle ()
// Data
@property (nonatomic, strong) NSNumber *superscriptValue;
@end

@implementation GONMarkupTextStyle
#pragma mark - Constructor
+ (NSArray *)allMarkups
{
    return @[[self superscriptedMarkup], [self subscriptedMarkup]];
}

+ (instancetype)superscriptedMarkup
{
    GONMarkupTextStyle *markup = [self markupForTag:GONMarkupTextStyle_Superscripted_TAG];

    markup.superscriptValue = @(1);

    return markup;
}

+ (instancetype)subscriptedMarkup
{
    GONMarkupTextStyle *markup = [self markupForTag:GONMarkupTextStyle_Subscripted_TAG];

    markup.superscriptValue = @(-1);

    return markup;
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    [configurationDictionary setObject:_superscriptValue
                                 forKey:(NSString *)kCTSuperscriptAttributeName];
}

@end
