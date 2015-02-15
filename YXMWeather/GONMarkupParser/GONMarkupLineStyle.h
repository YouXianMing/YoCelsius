//
//  GONMarkupLineStyle.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 03/02/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
//
//  Tag used to set underline / strikethrough style.
//  Attribute "word" can be set to apply style only on words. Default is "false".
//  Attribute "style" can be used to configure line style (single | thick | double). Default is "single".
//  Attribute "pattern" can be used to configure pattern style (solid | dot | dash | dashdot | dashdotdot). Default is "solid".
//  Attribute "color" can be used to configure line color. Default is the same as text".
//
//  Colors are handled via NSString+Color, using "representedColor" category method
//  Have a look at https://github.com/nicolasgoutaland/NSString-Color for more information

//
//  Examples
//
//  <u>underline text</>
//  <u word="true">underline text, only for words</>
//  <u pattern="dashdot">underline text with dashdot pattern</>
//  <u pattern="dashdot" word="true">underline text with dashdot pattern, only for words</>
//  <strike>strikethrough text</>
//  <strike pattern="dashdot">strikethrough text with dashdot pattern</>
//  <strike pattern="dashdot" word="true">strikethrough text with dashdot pattern, only for words</>
//
#import "GONMarkup.h"

// Tag
#define GONMarkupLineStyle_Underline_TAG             @"u"
#define GONMarkupLineStyle_Strikethrough_TAG         @"strike"

// Attributes
#define GONMarkupLineStyle_TAG_word_ATT              @"word"
#define GONMarkupLineStyle_TAG_style_ATT             @"style"
#define GONMarkupLineStyle_TAG_pattern_ATT           @"pattern"
#define GONMarkupLineStyle_TAG_color_ATT             @"color"

@interface GONMarkupLineStyle : GONMarkup
/* Return all markups */
+ (NSArray *)allMarkups;

/* Default markup to add underline support */
+ (instancetype)underlineMarkup;

/* Default markup to add strikethrough support */
+ (instancetype)strikethroughMarkup;
@end
