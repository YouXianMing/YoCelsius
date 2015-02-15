//
//  GONMarkupBold.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Tag updating current font style to bold
//  This tag may not work if no bold version of current font is available.
//  overrideBlock (GONMarkupFontTraits) allows you to override font. For example, you can used it to return a medium font instead of bold one.
//  If overrideBlock is set, it will be called first. Is nil is returned, system will try to automatically resolve font
//
//  Examples
//
//  <b>bold text</>

#import "GONMarkupFontTraits.h"

#define GONMarkupBold_TAG                 @"b"

@interface GONMarkupBold : GONMarkupFontTraits

/* Default markup to add bold support */
+ (instancetype)boldMarkup;
@end
