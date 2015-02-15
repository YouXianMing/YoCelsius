//
//  GONMarkupReset.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Reset tag is used to reset all current configuration, and use default one
//  It allows you to protect a string portion, for example :
//  <red>this text is red<strong>red strong <reset> <yellow> yellow default <yellow> </reset> red strong </strong> red </red>
//
//  "all" attribute can be used to also remove default configuration
//  sharedContext will also be reset

#import "GONMarkup.h"

// Context
#define GONMarkupReset_SAVED_CONTEXT_KEY  @"GONMarkupReset.savedContext"   // Saved context before reset, to be restored on tag end

// Tag
#define GONMarkupReset_TAG                 @"reset"

// Attributes
#define GONMarkupReset_TAG_all_ATT         @"all"   // If true default parser configuration won't be set, default is false.

@interface GONMarkupReset : GONMarkup
/* Class constructor */
+ (instancetype)resetMarkup;

@end
