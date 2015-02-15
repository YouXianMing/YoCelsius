//
//  GONMarkupInc.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Define a markup to increment font size. By default, font is increased by 1 point.
//  You can specify another increment value with "value" attribute.
//
//  Examples
//
//  <inc>text</>
//  <inc value="5">text</>

#import "GONMarkup.h"

// Tag
#define GONMarkupInc_TAG                 @"inc"

// Attributes
#define GONMarkupInc_TAG_value_ATT       @"value"

@interface GONMarkupInc : GONMarkup
/* Default markup to add text size increment support */
+ (instancetype)incMarkup;
@end
