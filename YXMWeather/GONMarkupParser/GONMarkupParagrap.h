//
//  GONMarkupParagrap.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 06/08/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Markup to handle paragraphs
//  A paragraph will automatically insert a new line after text
//
//  Example
//
//  <p>First paragraph</p>
//
#import "GONMarkup.h"

// Tag
#define GONMarkupParagrap_TAG                 @"p"

@interface GONMarkupParagrap : GONMarkup
/* Class constructor */
+ (instancetype)paragraphMarkup;
@end
