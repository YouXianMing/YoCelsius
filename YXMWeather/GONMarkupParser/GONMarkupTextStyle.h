//
//  GONMarkupTextStyle.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/07/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Tag updating current font style (subscripted / superscripted).
//
//  Examples
//
//  <sup>superscripted text</>
//  <sub>subscripted text</>

#import "GONMarkup.h"

// Tag
#define GONMarkupTextStyle_Superscripted_TAG        @"sup"
#define GONMarkupTextStyle_Subscripted_TAG          @"sub"

@interface GONMarkupTextStyle : GONMarkup
/* Return all markups */
+ (NSArray *)allMarkups;

/* Default markup to add superscripted support */
+ (instancetype)superscriptedMarkup;

/* Default markup to add subscripted support */
+ (instancetype)subscriptedMarkup;
@end


