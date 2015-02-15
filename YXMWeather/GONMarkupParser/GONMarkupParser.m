//
//  GONMarkupParser.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONMarkupParser.h"
#import "GONMarkup+Private.h"
#import "GONMarkupDefaultMarkups.h"
#import "GONMarkupParserUtils.h"

#define MARKUP_REGEX                           @"(.*?)(<[^>]+>|\\Z)"
#define ATTRIBUTES_REGEX                       @"([^\\s=]+)\\s*=\\s*('(\\\\'|[^']*')|\"(\\\\\"|[^\"])*\")"
#define LOG_IF_DEBUG(level, msg, ...)          do {if (_logLevel & level) { NSLog(@"MarkupParser : %@", [NSString stringWithFormat:msg, ##__VA_ARGS__]); }} while(0)

@interface GONMarkupParser ()
// Style
@property (nonatomic, strong) NSMutableDictionary *defaultConfiguration;     // Default attributed string configuration

// Fonts
@property (nonatomic, strong) NSMutableDictionary *dicRegisteredFonts;       // Registered fonts

// Data
@property (nonatomic, strong) NSMutableDictionary *dicCurrentMarkup;         // Dictionary representation of markups
@property (nonatomic, strong) NSRegularExpression *markupRegex;              // Regular expression to extract tokens
@property (nonatomic, strong) NSRegularExpression *attributesRegex;          // Attributes regex

// Ephemeral internal data. Used to reduce parameters count in internal methods
@property (nonatomic, strong) NSMutableArray      *configurationsStack;      // Configurations stack
@property (nonatomic, strong) NSMutableArray      *markupsStack;             // Markups stack
@property (nonatomic, strong) NSMutableArray      *markupAttributesStack;    // Markups attributes stack
@property (nonatomic, strong) NSMutableDictionary *currentContext;           // Current context
@end

@implementation GONMarkupParser
#pragma mark - Constructor
+ (GONMarkupParser *)defaultMarkupParser
{
    GONMarkupParser *parser = [[GONMarkupParser alloc] init];

    [parser addMarkup:[GONMarkupItalic italicMarkup]];
    [parser addMarkup:[GONMarkupBold boldMarkup]];

    [parser addMarkup:[GONMarkupDec decMarkup]];
    [parser addMarkup:[GONMarkupInc incMarkup]];

    [parser addMarkup:[GONMarkupAnchor anchorMarkup]];
    [parser addMarkup:[GONMarkupFont fontMarkup]];
    [parser addMarkup:[GONMarkupColor colorMarkup]];
    [parser addMarkup:[GONMarkupLineBreak lineBreakMarkup]];
    [parser addMarkup:[GONMarkupReset resetMarkup]];
    [parser addMarkup:[GONMarkupParagrap paragraphMarkup]];

    [parser addMarkups:[GONMarkupLineStyle allMarkups]];
    [parser addMarkups:[GONMarkupTextStyle allMarkups]];
    [parser addMarkups:[GONMarkupList allMarkups]];
    [parser addMarkups:[GONMarkupAlignment allMarkups]];

    return parser;
}

+ (GONMarkupParser *)emptyMarkupParser
{
    return [[GONMarkupParser alloc] init];
}

- (id)init
{
    if (self = [super init])
    {
        _markupRegex = [[NSRegularExpression alloc] initWithPattern:MARKUP_REGEX
                                                            options:NSRegularExpressionDotMatchesLineSeparators
                                                              error:nil];

        _attributesRegex = [[NSRegularExpression alloc] initWithPattern:ATTRIBUTES_REGEX
                                                                options:NSRegularExpressionDotMatchesLineSeparators
                                                                  error:nil];

        _assertOnError           = NO;
        _logLevel                = GONMarkupParserLogLevelNone;
        _defaultConfiguration    = [[NSMutableDictionary alloc] init];
        _dicCurrentMarkup        = [[NSMutableDictionary alloc] init];
        _dicRegisteredFonts      = [[NSMutableDictionary alloc] init];

        _replaceNewLineCharactersFromInputString = NO;
        _replaceHTMLCharactersFromOutputString   = YES;
    }

    return self;
}

#pragma mark - Markup management
- (void)addMarkup:(GONMarkup *)markup
{
    // Nothing to do if already added to parser
    if (markup.parser == self)
        return;

    if (markup.parser != nil)
        @throw @"Error, a Markup can be used by only one parser at a time";

    // Bind to parser
    markup.parser = self;
    [_dicCurrentMarkup setObject:markup
                          forKey:markup.tag];
}

- (GONMarkup *)markupForTag:(NSString *)tag
{
    // Retrieve markup
    return [_dicCurrentMarkup objectForKey:tag];
}

- (void)addMarkups:(id <NSFastEnumeration>)markups
{
    for (GONMarkup *markup in markups)
        [self addMarkup:markup];
}

- (void)removeMarkup:(GONMarkup *)markup
{
    GONMarkup *currentMarkup = [_dicCurrentMarkup objectForKey:markup.tag];
    if (currentMarkup == markup)
    {
        // Remove parser link
        markup.parser = nil;
        [_dicCurrentMarkup removeObjectForKey:markup.tag];
    }
}

- (void)removeMarkups:(id <NSFastEnumeration>)markups
{
    for (GONMarkup *markup in markups)
        [self removeMarkup:markup];
}

- (void)removeAllMarkups
{
    for (GONMarkup *markup in [_dicCurrentMarkup allValues])
        markup.parser = nil;

    [_dicCurrentMarkup removeAllObjects];
}

#pragma mark - Parser
- (NSMutableAttributedString *)attributedStringFromString:(NSString *)string
{
    return [self attributedStringFromString:string
                                      error:nil];
}

- (NSMutableAttributedString *)attributedStringFromString:(NSString *)string error:(NSError **)error
{
    LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Input string :\n%@\n", string);

    // Check for nil values
    if (!string)
    {
        LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Input string was <nil>, returning empty string");
        return [[NSMutableAttributedString alloc] init];
    }

    // Make input string mutable
    NSMutableString *inputString = [string mutableCopy];

    // Handle pre processing
    LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Preprocessing string");
    if (_preProcessingBlock)
        _preProcessingBlock(inputString);

    // Replace new line characters
    if (_replaceNewLineCharactersFromInputString)
        inputString = [[[inputString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "] mutableCopy];

    // Parse input string
    NSMutableAttributedString *resString = [self parseString:inputString error:error];

    if (error)
        LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Parsing completed with an error <%@>", *error);
    else
        LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Parsing completed without error");

    // Replace html entities
    if (_replaceHTMLCharactersFromOutputString)
        [GONMarkupParserUtils cleanHTMLEntitiesFromString:resString.mutableString];

    // Handle post processing
    LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Postprocessing string");
    if (_postProcessingBlock)
        _postProcessingBlock(resString);

    LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Result string :\n%@\n", resString);

    return resString;
}

- (NSMutableAttributedString *)parseString:(NSString *)inputString error:(NSError **)error
{
    // Init stack
    _configurationsStack   = [[NSMutableArray alloc] init];
    _currentContext        = [[NSMutableDictionary alloc] init];
    _markupsStack          = [[NSMutableArray alloc] init];
    _markupAttributesStack = [[NSMutableArray alloc] init];

    // Parse string
    NSArray *results = [_markupRegex matchesInString:inputString
                                             options:0
                                               range:NSMakeRange(0, inputString.length)];

    // Prepare result string
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] init];

    // Browse chunks
    NSString *tag;
    BOOL autoclosingMarkup;
    [resultString beginEditing];
    for (NSTextCheckingResult *result in results)
    {
        // Split string
        NSArray *parts = [[inputString substringWithRange:result.range] componentsSeparatedByString:@"<"];
        // Append extracted string
        [resultString appendAttributedString:[self computeFinalExtractedString:[parts firstObject]]];

        // Check if a tag was found
        if (parts.count > 1)
        {
            // Extract tag and clean it
            tag = [parts objectAtIndex:1];
            tag = [tag substringToIndex:tag.length - 1]; // Remove final >
            tag = [tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

            if ([tag rangeOfString:@"/"].location == 0)
            {
                // Lowercase tag, trim closing character
                tag = [[tag substringFromIndex:1] lowercaseString];

                // Trim potential remaining white spaces
                tag = [tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

                // Closing current tag, so append result string
                [resultString appendAttributedString:[self computeSuffixString]];
                [self handleClosingTag:tag error:error];
            }
            else
            {
                // Check if autoclosing markup or not
                autoclosingMarkup = [tag rangeOfString:@"/" options:NSBackwardsSearch].location == (tag.length - 1);

                // If autoclosing markup, trim last /
                if (autoclosingMarkup)
                    tag = [tag substringToIndex:tag.length - 1];

                // Trim potential remaining white spaces
                tag = [tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

                // Split tag / attributes
                tag = [self extractTagAndPushAttributesFromTag:tag];

                // Handle autoclosing markup
                if (autoclosingMarkup)
                {
                    // Opening tag
                    [self handleOpeningTag:tag error:error];

                    // Append an extracted empty string
                    [resultString appendAttributedString:[self computePrefixString]];
                    [resultString appendAttributedString:[self computeFinalExtractedString:@""]];
                    [resultString appendAttributedString:[self computeSuffixString]];

                    // Close tag
                    [self handleClosingTag:tag error:error];
                }
                else
                {
                    // Opening tag
                    [self handleOpeningTag:tag error:error];
                    [resultString appendAttributedString:[self computePrefixString]];
                }
            }
        }
    }

    [resultString endEditing];

    if (_configurationsStack.count != 0)
    {
        LOG_IF_DEBUG(GONMarkupParserLogLevelUnbalancedTags, @"Parsing completed, but stack isn't empty, some closing tags seems missing :\nStack :%@\n", _configurationsStack);
        [self generateError:error tag:nil];
    }

    // Flush unuseful data
    _markupsStack          = nil;
    _configurationsStack   = nil;
    _currentContext        = nil;
    _markupAttributesStack = nil;

    return resultString;
}

#pragma mark - Utils
- (NSString *)extractTagAndPushAttributesFromTag:(NSString *)tag
{
    // Check for attributes
    NSRange range = [tag rangeOfString:@" "];
    NSDictionary *attributes = nil;
    NSString *extractedTag;
    if (range.location == NSNotFound)
    {
        // No attributed to extract, and tag is full string
        extractedTag = tag;
    }
    else
    {
        // There may be some attributes, so extract tag
        extractedTag = [tag substringToIndex:range.location];

        attributes = [self extractAttributesFromString:[tag substringFromIndex:range.location]];
    }

    // Check if some attributes were found
    [_markupAttributesStack addObject:(attributes.count ? attributes : [NSNull null])];

    return [extractedTag lowercaseString];
}

- (NSDictionary *)attributesForCurrentTag
{
    id attributes = [_markupAttributesStack lastObject];
    if (attributes == [NSNull null])
        return nil;

    return attributes;
}

- (NSDictionary *)extractAttributesFromString:(NSString *)string
{
    NSMutableDictionary *dicAttributes = [[NSMutableDictionary alloc] init];

    // Parse string
    NSArray *results = [_attributesRegex matchesInString:string
                                                 options:0
                                                   range:NSMakeRange(0, string.length)];

    // Browse chunks
    NSString *matchedString;
    NSRange range;
    NSString *attributeKey;
    NSMutableString *attributeValue;
    for (NSTextCheckingResult *result in results)
    {
        // Extract matched string
        matchedString = [string substringWithRange:result.range];
        
        // Look for character to split string
        range = [matchedString rangeOfString:@"="];

        // Extract key
        attributeKey    = [[matchedString substringToIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        // Extract value
        attributeValue  = [[[matchedString substringFromIndex:range.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];

        // Clean value, by trimming enclosing quotes / double quotes, cleaning potential &quot; entities
        [attributeValue replaceCharactersInRange:NSMakeRange(attributeValue.length - 1, 1) withString:@""];
        [attributeValue replaceCharactersInRange:NSMakeRange(0, 1)                         withString:@""];
        [attributeValue replaceOccurrencesOfString:@"&quot;" withString:@"\"" options:0 range:NSMakeRange(0, attributeValue.length)];

        // Clean pontential html entities in string
        [dicAttributes setObject:attributeValue
                          forKey:attributeKey];
    }

    return dicAttributes;
}

#pragma mark - Tag content managements
- (NSAttributedString *)computePrefixString
{
    GONMarkup *currentMarker = [_markupsStack lastObject];
    if (currentMarker && ![currentMarker isKindOfClass:[NSNull class]])
    {
        return [[NSAttributedString alloc] initWithString:[currentMarker prefixStringForContext:_currentContext attributes:[self attributesForCurrentTag]]
                                               attributes:[self currentConfiguration]];
    }

    return [[NSAttributedString alloc] initWithString:@"" attributes:[self currentConfiguration]];
}

- (NSAttributedString *)computeSuffixString
{
    GONMarkup *currentMarker = [_markupsStack lastObject];
    if (currentMarker && ![currentMarker isKindOfClass:[NSNull class]])
    {
        return [[NSAttributedString alloc] initWithString:[currentMarker suffixStringForContext:_currentContext
                                                                                     attributes:[self attributesForCurrentTag]]
                                               attributes:[self currentConfiguration]];
    }

    return [[NSAttributedString alloc] initWithString:@"" attributes:[self currentConfiguration]];
}

- (NSAttributedString *)computeFinalExtractedString:(NSString *)inputString
{
    GONMarkup *currentMarker = [_markupsStack lastObject];
    if (currentMarker && ![currentMarker isKindOfClass:[NSNull class]])
    {
        return [[NSAttributedString alloc] initWithString:[currentMarker updatedContentString:inputString
                                                                                      context:_currentContext
                                                                                   attributes:[self attributesForCurrentTag]]
                                               attributes:[self currentConfiguration]];
    }

    return [[NSAttributedString alloc] initWithString:inputString attributes:[self currentConfiguration]];
}

#pragma mark - Tag managements
- (void)handleClosingTag:(NSString *)tag error:(NSError **)error
{
    // Look for full style closing tag, @"//"
    // Checking only for one /, because first one was trimmed
    if ([tag rangeOfString:@"/"].location == 0)
    {
        if (!_configurationsStack.count)
        {
            LOG_IF_DEBUG(GONMarkupParserLogLevelUnbalancedTags, @"Trying to close all tags, but stack is empty");
            [self generateError:error tag:tag];
        }
        else
        {
            GONMarkup *markup;
            NSMutableDictionary *currentTagConfiguration;
            for (NSInteger i=_markupsStack.count - 1; i>=0; i--)
            {
                markup = [_markupsStack objectAtIndex:i];
                currentTagConfiguration = [_configurationsStack objectAtIndex:i];

                [markup closingMarkupFound:tag
                             configuration:currentTagConfiguration
                                   context:_currentContext
                                attributes:([_markupAttributesStack objectAtIndex:i] == [NSNull null] ? nil : [_markupAttributesStack objectAtIndex:i])];
            }

            [_configurationsStack removeAllObjects];
            [_markupsStack removeAllObjects];
            [_currentContext removeAllObjects];
            [_markupAttributesStack removeAllObjects];

            LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Closing all tags\nStack : %@\n", _configurationsStack);
        }
    }
    else
    {
        // Check if available tags
        if (!_configurationsStack.count)
        {
            // Closing a tag, but tags stack is empty
            LOG_IF_DEBUG(GONMarkupParserLogLevelUnbalancedTags, @"Trying to close last tag, but stack is empty");
            [self generateError:error tag:tag];
        }
        else
        {
            
            // Extract current markup
            GONMarkup *markup = [_markupsStack lastObject];

            // Present error when closing an unkwnow markup
            if (markup && ![markup isKindOfClass:[NSNull class]])
            {
                // Check that closing that is matching opening one
                if (tag.length)
                {
                    if (![tag isEqualToString:markup.tag])
                    {
                        LOG_IF_DEBUG(GONMarkupParserLogLevelUnbalancedTags, @"Closing tag found <%@>, is not matching currently opened one <%@>", tag, markup.tag);
                        [self generateError:error tag:tag];
                    }
                }

                [markup closingMarkupFound:tag
                             configuration:[_configurationsStack lastObject]
                                   context:_currentContext
                                attributes:[self attributesForCurrentTag]];
            }

            // Remove last tag objet
            [_configurationsStack removeLastObject];
            [_markupsStack removeLastObject];
            [_markupAttributesStack removeLastObject];

            LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Closing tag (%@)\nStack : %@\n", tag, _configurationsStack);
        }
    }
}

- (void)handleOpeningTag:(NSString *)tag error:(NSError **)error
{
    // Prepare tag configuration
    NSMutableDictionary *currentTagConfiguration;
    if (!_configurationsStack.count)
        currentTagConfiguration = [_defaultConfiguration mutableCopy];
    else
        currentTagConfiguration = [[_configurationsStack lastObject] mutableCopy];

    // Retrieve markup associated to tag
    GONMarkup *markup = [self markupForTag:tag];

    // Ensure a markup was found
    if (!markup)
    {
        LOG_IF_DEBUG(GONMarkupParserLogLevelUnknownTag, @"No markup found for tag <%@>\n", tag);
        [self generateError:error
                        tag:tag];

        [_markupsStack addObject:[NSNull null]];
    }
    else
    {
        [markup openingMarkupFound:tag
                     configuration:currentTagConfiguration
                           context:_currentContext
                        attributes:[self attributesForCurrentTag]];

        [_markupsStack addObject:markup];
    }

    // Hold configuration
    [_configurationsStack addObject:currentTagConfiguration];

    LOG_IF_DEBUG(GONMarkupParserLogLevelWorkflow, @"Opening tag (%@)\nStack : %@\n", tag, _configurationsStack);
}

- (NSDictionary *)currentConfiguration
{
    if (!_configurationsStack.count)
        return [_defaultConfiguration copy];

    return [[_configurationsStack lastObject] copy];
}

#pragma mark - Fonts management
- (void)registerFont:(UIFont *)font forKey:(NSString *)key
{
    [_dicRegisteredFonts setObject:font
                            forKey:key];
}

- (UIFont *)fontForKey:(NSString *)key
{
    return [_dicRegisteredFonts objectForKey:key];
}

- (void)unregisterFontForKey:(NSString *)key
{
    [_dicRegisteredFonts removeObjectForKey:key];
}

#pragma mark - Error handling
- (void)generateError:(NSError **)error tag:(NSString *)tag
{
    // Assert only is requested
    if (_assertOnError)
        NSAssert1(NO, @"An error was generated parsing following text, found at markup <%@>", tag);

    if (error)
    {
        // Initialize user info
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:@"Input string is malformed. Ouput attributed string may not be displayed correctly"
                                                                           forKey:NSLocalizedDescriptionKey];

        // Add tag if avalaible
        if (tag)
        {
            [userInfo setObject:tag
                         forKey:GONMarkupParser_incorrectClosingTag_KEY];
        }

        // Build error
        *error = [NSError errorWithDomain:GONMarkupParser_ERROR_DOMAIN
                                     code:GONMarkupParser_StringMalformed_ERROR_CODE
                                 userInfo:userInfo];
    }
}

#pragma mark - Getters
- (NSArray *)markups
{
    return [[_dicCurrentMarkup allValues] copy];
}

- (NSDictionary *)registeredFonts
{
    return [_dicRegisteredFonts copy];
}

@end
