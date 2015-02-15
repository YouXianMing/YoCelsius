//
//  GONMarkupItalic.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Tag updating current font style to italic
//  This tag may not work if no italic version of current font is available.
//  overrideBlock (GONMarkupFontTraits) allows you to override font. For example, you can used it to return a medium italic font instead of bold italic one.
//  If overrideBlock is set, it will be called first. Is nil is returned, system will try to automatically resolve font
//
//  Examples
//
//  <i>italic text</>

#import "GONMarkupFontTraits.h"

#define GONMarkupItalic_TAG               @"i"

@interface GONMarkupItalic : GONMarkupFontTraits

/* Default markup to add italic support */
+ (instancetype)italicMarkup;
@end
