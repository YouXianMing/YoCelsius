//
//  GONMarkupDec.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Define a markup to decrement font size. By default, font is decreased by 1 point.
//  You can specify another decrement value with "value" attribute.
//
//  Examples
//
//  <dec>text</>
//  <dec value="5">text</>

#import "GONMarkup.h"

// Tag
#define GONMarkupDec_TAG                   @"dec"

// Attributes
#define GONMarkupDec_TAG_value_ATT       @"value"

@interface GONMarkupDec : GONMarkup
/* Default markup to add text size decrement support */
+ (instancetype)decMarkup;
@end
