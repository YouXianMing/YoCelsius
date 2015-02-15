//
//  UITextView+GONMarkupParser.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 04/02/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//

#import "UITextView+GONMarkupParser.h"
#import "GONMarkupParserManager.h"
#import "GONMarkupParserUtils.h"

@implementation UITextView (GONMarkupParser)
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