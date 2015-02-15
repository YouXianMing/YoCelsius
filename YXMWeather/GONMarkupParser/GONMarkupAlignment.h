//
//  GONMarkupAlignment.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 22/07/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//
//  Markup used to handle text alignment.
//  This markup will set a NSMutableParagraphStyle object under NSParagraphStyleAttributeName key.
//  Be sure to make a mutable copy of it before updating when adding new tags
//
//  Examples
//
//  <left>left aligned text</>
//  <right>right aligned text</>
//  <center>center aligned text</>
//  <justified>justified aligned text</>
//  <natural>natural aligned text</>

#import "GONMarkup.h"

// Tag
#define GONMarkupAlignment_left_TAG                 @"left"
#define GONMarkupAlignment_right_TAG                @"right"
#define GONMarkupAlignment_center_TAG               @"center"
#define GONMarkupAlignment_justified_TAG            @"justified"
#define GONMarkupAlignment_natural_TAG              @"natural"

@interface GONMarkupAlignment : GONMarkup
/* Return all alignment markups */
+ (NSArray *)allMarkups;

/* Default markup to add center text alignment support */
+ (instancetype)centerMarkup;

/* Default markup to add left text alignment support */
+ (instancetype)leftMarkup;

/* Default markup to add right text alignment support */
+ (instancetype)rightMarkup;

/* Default markup to add justified text alignment support */
+ (instancetype)justifiedMarkup;

/* Default markup to add natural text alignment support */
+ (instancetype)naturalMarkup;

@end
