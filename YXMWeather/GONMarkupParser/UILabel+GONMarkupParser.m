//
//  UILabel+GONMarkupParser.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 08/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "UILabel+GONMarkupParser.h"
#import "GONMarkupParserManager.h"
#import "GONMarkupParserUtils.h"

@implementation UILabel (GONMarkupParser)
#pragma mark - GONMarkupParser
- (void)setMarkedUpText:(NSString *)text parser:(GONMarkupParser *)parser
{
    self.attributedText = [GONMarkupParserUtils attributedString:parser
                                                      withString:text
                                                     defautColor:self.textColor
                                                     defaultFont:self.font
                                                defaultAlignment:self.textAlignment];
}

- (void)setMarkedUpText:(NSString *)text
{
    [self setMarkedUpText:text
                   parser:nil];
}
@end
