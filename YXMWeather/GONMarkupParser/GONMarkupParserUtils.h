//
//  GONMarkupParserUtils.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 08/08/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Utils
//  Why not using some categories Sir ? Because I'm pretty sure everyone already have a cleanHTMLEntities method on their strings,
//  and I don't want to conflict with existing methods, nor adding a pod dependency that will add tons of new methods
@class GONMarkupParser;

@interface GONMarkupParserUtils : NSObject
/* Clean HTML entities from string */
+ (void)cleanHTMLEntitiesFromString:(NSMutableString *)inputString;

/* Helper method to generate an attribtued string from a parser, but allowing to set default text color, text alignment and font 
 * if they are not set in parser default configuration.
 * This mthod will update parser default configuration, generate string, then revert configuration back to previous state
 * Used in UILAbel+GONMarkupParser and UITextField+GONMarkupParser categories to prevent duplicated code
 * If parser is nil, [GONMarkupParserManager sharedParser] will be used
 */
+ (NSAttributedString *)attributedString:(GONMarkupParser *)parser
                              withString:(NSString *)inputString
                             defautColor:(UIColor *)defaultColor
                             defaultFont:(UIFont *)defaultFont
                        defaultAlignment:(NSTextAlignment)defaultAlignment;
@end
