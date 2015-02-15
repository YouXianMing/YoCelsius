//
//  GONMarkupLineBreak.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Markup to handle <br/> characters, generating a new line
//
//  Example
//
//  <br />

#import "GONMarkup.h"

// Tag
#define GONMarkupLineBreak_TAG                 @"br"

@interface GONMarkupLineBreak : GONMarkup
/* Class constructor */
+ (instancetype)lineBreakMarkup;
@end
