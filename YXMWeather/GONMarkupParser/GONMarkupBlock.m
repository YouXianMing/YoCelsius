//
//  GONMarkupBlock.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupBlock.h"

@implementation GONMarkupBlock
#pragma mark - Constructor
+ (instancetype)blockMarkup:(NSString *)tag
{
    return [self markupForTag:tag];
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_openingMarkupBlock)
        _openingMarkupBlock(configurationDictionary, tag, context, dicAttributes);
}

- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_closingMarkupBlock)
        _closingMarkupBlock(configurationDictionary, tag, context, dicAttributes);
}

- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_updatedContentStringBlock)
        return _updatedContentStringBlock(string, context, dicAttributes);

    return [super updatedContentString:string context:context attributes:dicAttributes];
}

- (NSString *)prefixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_prefixStringForContextBlock)
        return _prefixStringForContextBlock(context, dicAttributes);

    return [super prefixStringForContext:context attributes:dicAttributes];
}

- (NSString *)suffixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_suffixStringForContextBlock)
        return _suffixStringForContextBlock(context, dicAttributes);

    return [super suffixStringForContext:context attributes:dicAttributes];
}
@end
