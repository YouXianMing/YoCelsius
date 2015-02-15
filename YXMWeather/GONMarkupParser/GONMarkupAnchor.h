//
//  GONMarkupAnchor.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 04/02/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
//  Define a markup to add anchor support
//  You can specify link value with "value" attribute.
//
//  To detect user touch on link :
//  - display attributed string in a UITextView
//  - configure UITextView selectable property to YES and isEditable to NO
//  - set delegate
//  - implement "textView:shouldInteractWithURL:inRange:" method
//
//  Examples
//
//  <a href="#1">Link 1</>
//  <a href="http://www.apple.com">Link to apple.com</>
//  <a href="myscheme://myapp">Custom link</>

#import "GONMarkup.h"

// Tag
#define GONMarkupAnchor_TAG                 @"a"

// Attributes
#define GONMarkupAnchor_TAG_href_ATT       @"href"

@interface GONMarkupAnchor : GONMarkup
/* Default markup to add anchor support */
+ (instancetype)anchorMarkup;
@end
