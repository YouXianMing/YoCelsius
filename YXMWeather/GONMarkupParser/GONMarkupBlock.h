//
//  GONMarkupBlock.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Markup using a block as parameters. Useful to add new markup without creating new subclasses


#import "GONMarkup.h"

@interface GONMarkupBlock : GONMarkup
/* Class contructor
 */
+ (instancetype)blockMarkup:(NSString *)tag;

@property (nonatomic, copy) void(^openingMarkupBlock)(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context, NSDictionary *dicAttributes);  // Called when opening tag is found
@property (nonatomic, copy) void(^closingMarkupBlock)(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context, NSDictionary *dicAttributes);  // Called when closing tag is found

@property (nonatomic, copy) NSString *(^prefixStringForContextBlock)(NSMutableDictionary *context, NSDictionary *dicAttributes);                 // Called to generate prefix
@property (nonatomic, copy) NSString *(^suffixStringForContextBlock)(NSMutableDictionary *context, NSDictionary *dicAttributes);                 // Called to generate suffix
@property (nonatomic, copy) NSString *(^updatedContentStringBlock)(NSString *string, NSMutableDictionary *context, NSDictionary *dicAttributes); // Called when extracted string is complete
@end
