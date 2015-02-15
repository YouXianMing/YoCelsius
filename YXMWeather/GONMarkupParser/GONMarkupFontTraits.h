//
//  GONMarkupFontTraits.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 22/09/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//
//  Super class for markers updating font traits
//  overrideBlock allows you to override font. For example, you can used it to return a medium font instead of bold one.
//  If overrideBlock is set, it will be called first. Is nil is returned, sysytem will try to automatically resolve font
//  Also note that if an overrideBlock is set, it will be called even is current font have needed trait.
//
//  You may not need to use this class directly. Use subclasses instead (GONMarkupBold, GONMarkupItalic)

#import "GONMarkup.h"

@interface GONMarkupFontTraits : GONMarkup {
}

/* Class constructor */
+ (instancetype)fontTraitsMarkup:(NSString *)tag traits:(UIFontDescriptorSymbolicTraits )trait;

@property (nonatomic, copy) UIFont *(^overrideBlock)(UIFont *font);             // Should return a font. Markup will automatically update font to needed size.
@property (nonatomic, assign, readonly) UIFontDescriptorSymbolicTraits trait;
@end
