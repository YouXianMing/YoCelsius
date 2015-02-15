//
//  GONMarkupList.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupList.h"
#import "GONMarkupListItem.h"
#import "GONMarkup+Private.h"

@interface GONMarkupList ()
// Data
@property (nonatomic, assign) BOOL isOrdered;
@end

@implementation GONMarkupList
#pragma mark - Markup list
+ (NSArray *)allMarkups
{
    return @[[self listMarkup], [self orderedListMarkup], [GONMarkupListItem listItemMarkup]];
}

#pragma mark - Constructor
+ (instancetype)listMarkup
{
    GONMarkupList *markupList = [self markupForTag:GONMarkupList_unordered_TAG];

    markupList.isOrdered = NO;

    return markupList;
}

+ (instancetype)orderedListMarkup
{
    GONMarkupList *markupList = [self markupForTag:GONMarkupList_ordered_TAG];

    markupList.isOrdered =YES;

    return markupList;
}

#pragma mark - Markup lifecycle
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Compute indentation level
    NSInteger indentationLevel = 0;
    NSDictionary *currentConfiguration = [self currentContextConfiguration:GONMarkupList_CONFIGURATIONS_KEY
                                                               fromContext:context];
    if (currentConfiguration)
        indentationLevel = [[currentConfiguration objectForKey:GONMarkupList_INDENTATION_KEY] intValue] + 1;

    NSDictionary *configuration = [@{
                                     GONMarkupList_ORDERED_KEY       : @(_isOrdered),
                                     GONMarkupList_INDENTATION_KEY   : @(indentationLevel),
                                    } mutableCopy];

    [self pushConfiguration:configuration
                  toContext:context
                     forKey:GONMarkupList_CONFIGURATIONS_KEY];
}

- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    return @"";
}

- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    [self popContextConfiguration:GONMarkupList_CONFIGURATIONS_KEY
                      fromContext:context];
}

@end
