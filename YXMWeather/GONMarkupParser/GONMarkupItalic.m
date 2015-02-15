//
//  GONMarkupItalic.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupItalic.h"
#import "GONMarkup+Private.h"

@implementation GONMarkupItalic
#pragma mark - Constructor
+ (instancetype)italicMarkup
{
    return [super fontTraitsMarkup:GONMarkupItalic_TAG
                            traits:UIFontDescriptorTraitItalic];
}
@end
