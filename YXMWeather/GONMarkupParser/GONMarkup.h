//
//  GONMarkup.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//
//  Simple class defining a markup
//  You can use it as it, or override it to add more configuration
//
//  Tag name will be stored lowercased, so be careful when using multiple tags
//
//  Markup lifecycle :
//  - Once a tag is found, openingMarkupFound:configuration:context: method will be called
//  - Before parser append extracted string to result, following methods will be called
//      - prefixStringForContext:attributes: will be called, allowing tag to generate a prefix
//      - updatedContentString:context:attributes: will be called, allowing tag to update its content string (without prefix included)
//      - suffixStringForContext:attributes: will be called, allowing tag to generate a suffix
//  - Once tag is closed, closingMarkupFound:configuration:context: method will be called
//
//  Attributes should be space separated, values affected using equal sign, and between quotes or double quotes. To escape quotes / double quotes, use \
//  Be careful,text heere is intended to be loaded from a file, not directly set in code. If so, do not forget to escape \.
//  You can also use &quot;
//
//  Example :
//  Attribute               | Supported
//  -----------------------------------
//  <color value="red">     | YES
//  <color value = "red">   | YES
//  <color value = red>     | NO
//  <color value = "re"d">  | NO
//  <color value = "re\"d"> | YES
//  <color value='red'>     | YES
//  <color value = 'red'>   | YES
//  <color value = red>     | NO
//  <color value = "re'd">  | YES
//  <color value = 're"d'>  | YES
//
//
//  Markup instance will be reused each time a matching tag is found. To persist data, use context parameter.

@class GONMarkupParser;

@interface GONMarkup : NSObject
/* Class constructor */
+ (instancetype)markupForTag:(NSString *)tag;

/* Default constructor */
- (id)initWithTag:(NSString *)tag;

/* This method will be called if markup is matching current opening tag.
 * Object is responsible to update attributed string parameters in "configurationDictionary"
 *
 * "tag" is matching tag, allowing you to extract parameters
 * "context" is a mutable dictionary used by marker to add contextual information. This dictionary is shared throught all markers in a parser and is reset each time a new parse is started
 * It is used for example by list markers to handle list type, tabulation index and count
 *
 * You should override this method to implement new behavior
 */
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* Allows marker to prefix its content string
 * This method is called right after opening markup
 */
- (NSString *)prefixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* This method will be called once current marker tag is closed
 * This allows marker to update string content
 * "context" is the same as in openingMarkupFound:configuration:fromTag:context:
 *
 * Default implementation return input string
 */
- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* Allows marker to suffix its content string
 * This method is called right after opening markup
 */
- (NSString *)suffixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* This method will be called if markup is matching current closing tag.
 * Object is responsible to update attributed string parameters in "configurationDictionary"
 *
 * "tag" is matching tag, allowing you to extract parameters
 * "context" is a mutable dictionary use by marker to add contextual information. This dictionary is shared throught all markers in a parser and is reset each time a new parse is started
 * It is used for example by list markers to handle list type, tabulation index and count
 *
 * You should override this method to implement new behavior
 */
- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;


@property (nonatomic, copy, readonly) NSString *tag;            // Have to be unique. Used to speed up rules matching, when using tags without parameters
@property (nonatomic, weak, readonly) GONMarkupParser *parser;  // Parser the markup is attached to
@end
