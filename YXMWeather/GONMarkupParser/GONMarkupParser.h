//
//  GONMarkupParser.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//
//  A simple string parser, allowing string manipulation, usually used to parse HTML like string.
//  You have to define your own rules and ensure that tags are wellformed
//
//  To close a tag, you do not have to specity its name, </> is valid
//  <//> is also valid to close all previoulsy opened tags
//
// History
// -------
// 0.5 Initial release

// Roadmap
// -------
// Evolution : Allow markup to be encoded (NSCoding)
// Evolution : Loading from PLIST file
// Evolution : Allow copy for parsers / markup

#import "GONMarkup.h"

#define GONMarkupParser_ERROR_DOMAIN                   @"error.markupParser"
#define GONMarkupParser_StringMalformed_ERROR_CODE     69
#define GONMarkupParser_incorrectClosingTag_KEY        @"incorrectClosingTag"

typedef enum : NSUInteger {
    GONMarkupParserLogLevelNone           = 0,              // No logs
    GONMarkupParserLogLevelUnbalancedTags = 0x01 << 0,      // Logs when unbalanced tags are found
    GONMarkupParserLogLevelUnknownTag     = 0x01 << 1,      // Logs when an unknow tag is found
    GONMarkupParserLogLevelWorkflow       = 0x01 << 2,      // Logs parser workflow (Very verbose)
    GONMarkupParserLogLevelFonts          = 0x01 << 3,      // Logs fonts errors (Very useful to detect missing bold / italic fonts)
    GONMarkupParserLogLevelAll            = 0xFF,           // Logs all
    GONMarkupParserLogLevelErrors         = GONMarkupParserLogLevelFonts | GONMarkupParserLogLevelUnknownTag | GONMarkupParserLogLevelUnbalancedTags
} GONMarkupParserLogLevel;

@interface GONMarkupParser : NSObject
// Constructors
/* Instanciate a new markup parser, configured to handle all default tags */
+ (GONMarkupParser *)defaultMarkupParser;

/* Instanciate a new empty markup parser. This parser won't have any configured tag
 * Same as [[GONMarkupParser alloc] init]
 */
+ (GONMarkupParser *)emptyMarkupParser;

/* Add a new markup to parser
 * A markup can be used in only one parser at a time
 * If you are trying to a markup already used by another parser, an exception willl be thrown
 */
- (void)addMarkup:(GONMarkup *)markup;

/* Add some markups */
- (void)addMarkups:(id <NSFastEnumeration>)markups;

/* Return a previously registered markup that can handle given tag */
- (GONMarkup *)markupForTag:(NSString *)tag;

/* Remove given markup from parser, if previously added */
- (void)removeMarkup:(GONMarkup *)markup;

/* Remove given markups from parser, if previously added */
- (void)removeMarkups:(id <NSFastEnumeration>)markups;

/* Remove all currently applied markups */
- (void)removeAllMarkups;

// Fonts management
/* Register given font */
- (void)registerFont:(UIFont *)font forKey:(NSString *)key;

/* Register given font */
- (UIFont *)fontForKey:(NSString *)key;

/* Register given font */
- (void)unregisterFontForKey:(NSString *)key;

/* Convert given string to an attributed string.
 * String will be parsed and updated according to stored markups
 * If nil is passed as parameter, an empty string will be returned
 *
 * anError may be set if input string seems malformed, but method will return a valid string. Only last error is returned.
 */
- (NSMutableAttributedString *)attributedStringFromString:(NSString *)string error:(NSError **)error;

/* Same as attributedStringFromString:string error:nil.
 * Because sometimes, you don't care about errors.
 */
- (NSMutableAttributedString *)attributedStringFromString:(NSString *)string;

@property (nonatomic, assign)           BOOL replaceNewLineCharactersFromInputString;                           // If YES, all [NSCharacterSet newlineCharacterSet] will be replaced by spaces from input string.
                                                                                                                // Replacing process will occur AFTER preprocessingBlock, BEFORE parsing.
                                                                                                                // Use <br/> and <p> to add new lines. Default is NO.

@property (nonatomic, assign)           BOOL replaceHTMLCharactersFromOutputString;                             // If YES, all HTML entities will be replaced in output string.
                                                                                                                // Replacing process will occur BEFORE postProcessingBlock, AFTER parsing.
                                                                                                                // Default is YES

@property (nonatomic, strong, readonly) NSMutableDictionary *defaultConfiguration;                              // Default attributed string configuration
@property (nonatomic, readonly)         NSArray *markups;                                                       // Retrieve all applied markups
@property (nonatomic, readonly)         NSDictionary *registeredFonts;                                          // Retrieve all applied markups
@property (nonatomic, copy)             void (^preProcessingBlock)(NSMutableString *inputString);               // Block automatically called to preprocess input string
@property (nonatomic, copy)             void (^postProcessingBlock)(NSMutableAttributedString *inputString);    // Block automatically called to postprocess result attributed string
@property (nonatomic, assign)           GONMarkupParserLogLevel logLevel;                                       // Bitmask to select displayed logs
@property (nonatomic, assign)           BOOL assertOnError;                                                     // Enables assert when an error is generated. Useful when debugging.
@end
