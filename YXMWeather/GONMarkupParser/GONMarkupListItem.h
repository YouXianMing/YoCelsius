//
//  GONMarkupListItem.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Class describing a list item
//  You can subclass it and override methods to handle custom bullets behavior

#import "GONMarkup.h"

// Tag
#define GONMarkupListItem_TAG                 @"li"

@interface GONMarkupListItem : GONMarkup
/* Default markup to add list item support */
+ (instancetype)listItemMarkup;

/* Method used to compute list item prefix, in ORDERED lists
 * You can override this method in subclasses to change behavior
 *
 * indentationLevel : Current item indentation level in list, when list are nested
 * position          : Current item position in parent list.
 * listConfiguration : Parent list configuration
 * context           : Shared context
 *
 * This method is expected to return a string. You MUST NOT return nil
 */
- (NSString *)orderedListItemPrefixForIndentation:(NSInteger)indentationLevel position:(NSInteger)position listConfiguration:(NSDictionary *)listConfiguration context:(NSMutableDictionary *)context;

/* Method used to compute list item prefix, in NON ORDERED lists
 * You can override this method in subclasses to change behavior
 *
 * indentationLevel : Current item indentation level in list, when list are nested
 * position          : Current item position in parent list.
 * listConfiguration : Parent list configuration
 * context            : Shared context
 *
 * This method is expected to return a string. You MUST NOT return nil
 */
- (NSString *)unorderedListItemPrefixForIndentation:(NSInteger)indentationLevel position:(NSInteger)position listConfiguration:(NSDictionary *)listConfiguration context:(NSMutableDictionary *)context;

@end
