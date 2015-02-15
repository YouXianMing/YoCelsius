//
//  GONMarkupListItem.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupListItem.h"
#import "GONMarkupList.h"
#import "GONMarkup+Private.h"

@implementation GONMarkupListItem
#pragma mark - Constructor
+ (instancetype)listItemMarkup
{
    return [self markupForTag:GONMarkupListItem_TAG];
}

#pragma mark - Internal configuration
+ (NSString *)bulletForIndentation:(NSInteger)anIndentation
{
    static NSArray *bullets = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bullets = @[@"\u2022", @"\u25E6"];   // Next should be @"\u25A0", @"\u25A1", but they are displayed too big
    });

    return [bullets objectAtIndex:anIndentation % bullets.count];
}

- (NSString *)unorderedListItemPrefixForIndentation:(NSInteger)indentationLevel position:(NSInteger)position listConfiguration:(NSDictionary *)aListConfiguration context:(NSMutableDictionary *)context
{
    NSString *indentation = [self listItemIndentation:indentationLevel];
    NSString *bullet = [[self class] bulletForIndentation:indentationLevel];

    return [NSString stringWithFormat:@"%@%@ ", indentation, bullet];
}

- (NSString *)orderedListItemPrefixForIndentation:(NSInteger)indentationLevel position:(NSInteger)position listConfiguration:(NSDictionary *)aListConfiguration context:(NSMutableDictionary *)context
{
    NSString *indentation = [self listItemIndentation:indentationLevel];
    NSString *bullet = [NSString stringWithFormat:@"%ld.%ld.", (long)indentationLevel + 1, (long)position];

    return [NSString stringWithFormat:@"%@%@ ", indentation, bullet];
}

#pragma mark - Content update
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Retrieve indentation level
    NSMutableDictionary *currentConfiguration = [self currentContextConfiguration:GONMarkupList_CONFIGURATIONS_KEY fromContext:context];
    [currentConfiguration setObject:@([[currentConfiguration objectForKey:GONMarkupList_POSITION_KEY] intValue] + 1)
                          forKey:GONMarkupList_POSITION_KEY];

    // Retrieve and update paragraph style
    NSMutableParagraphStyle *paragraphStyle = [self paragraphStyle:configurationDictionary];

    // Generate prefix string
    NSAttributedString *prefixString = [[NSAttributedString alloc] initWithString:[self prefixStringForContext:context attributes:dicAttributes]
                                                                       attributes:configurationDictionary];

    // Compute prefix string width
    paragraphStyle.headIndent = CGRectGetWidth([prefixString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1) options:0 context:nil]);
}

- (NSString *)prefixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Retrieve configuration
    NSDictionary *listConfiguration = [[context objectForKey:GONMarkupList_CONFIGURATIONS_KEY] lastObject];

    NSInteger indentation = [[listConfiguration objectForKey:GONMarkupList_INDENTATION_KEY] intValue];
    NSInteger position    = [[listConfiguration objectForKey:GONMarkupList_POSITION_KEY] intValue];
    BOOL isOrdered        = [[listConfiguration objectForKey:GONMarkupList_ORDERED_KEY] intValue];

    NSString *prefix;
    if (isOrdered)
        prefix = [self orderedListItemPrefixForIndentation:indentation position:position listConfiguration:listConfiguration context:context];
    else
        prefix = [self unorderedListItemPrefixForIndentation:indentation position:position listConfiguration:listConfiguration context:context];

    return prefix;
}

- (NSString *)suffixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    return @"\n";
}

#pragma mark - Utils
- (NSMutableParagraphStyle *)paragraphStyle:(NSMutableDictionary *)configurationDictionary
{
    NSMutableParagraphStyle *paragraphStyle = [[configurationDictionary objectForKey:NSParagraphStyleAttributeName] mutableCopy];
    if (!paragraphStyle)
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];

    // Hold updated paragraph style
    [configurationDictionary setObject:paragraphStyle
                                 forKey:NSParagraphStyleAttributeName];

    return paragraphStyle;
}

- (NSString *)listItemIndentation:(NSInteger)anIndentation
{
    NSMutableString *indentString = [[NSMutableString alloc] init];

    for (NSInteger i=0; i<anIndentation; i++)
        [indentString appendString:@"\t"];

    return indentString;
}
@end
