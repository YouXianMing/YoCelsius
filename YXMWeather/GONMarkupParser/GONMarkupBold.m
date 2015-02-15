//
//  GONMarkupBold.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupBold.h"
#import "GONMarkup+Private.h"

@implementation GONMarkupBold
#pragma mark - Constructor
+ (instancetype)boldMarkup
{
    return [super fontTraitsMarkup:GONMarkupBold_TAG
                            traits:UIFontDescriptorTraitBold];
}
@end
