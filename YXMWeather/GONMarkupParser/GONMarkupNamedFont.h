//
//  GONMarkupNamedFont.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Define a tag to set font / remove font
//  When encountered, contained text will use associated font

#import "GONMarkup.h"

@interface GONMarkupNamedFont : GONMarkup
/* Class constructor 
 * If font is nil, so this tag will reset current font to parser default one
 */
+ (instancetype)namedFontMarkup:(UIFont *)font forTag:(NSString *)tag;

@property (nonatomic, strong, readonly) UIFont *font;
@end
