//
//  GONMarkupList.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Markup used to handle lists
//  You HAVE to add GONMarkupListItem support to handle list properly
//
//  Example
//
//  <ul>
//      <li>first item</>
//      <li>second item</>
//      <li>third item</>
//  </>

#import "GONMarkup.h"

// Tag
#define GONMarkupList_unordered_TAG                 @"ul"
#define GONMarkupList_ordered_TAG                   @"ol"

// Context
#define GONMarkupList_CONFIGURATIONS_KEY  @"GONMarkupList.configurations"   // References an array, holding automatically pushed / popped tags configurations

#define GONMarkupList_INDENTATION_KEY     @"GONMarkupList.indentation"
#define GONMarkupList_POSITION_KEY        @"GONMarkupList.position"
#define GONMarkupList_ORDERED_KEY         @"GONMarkupList.ordered"

@interface GONMarkupList : GONMarkup
/* Return all markups, including list item one */
+ (NSArray *)allMarkups;

/* Default markup to add lists support */
+ (instancetype)listMarkup;

/* Default markup to add ordered lists support */
+ (instancetype)orderedListMarkup;

@end
