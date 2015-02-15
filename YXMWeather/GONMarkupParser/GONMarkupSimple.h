//
//  GONMarkupSimple.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 18/07/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//
//  Define a markup to automatically add attributes to current string
//  Content of style dictionary is added to current style dictionary
//  "style" dictionary is intended to be the same as you may pass to configure an NSMutableAttributedString using -setAttributes:range: method
//
//  If overriding NSParagraphStyleAttributeName, check merging strategy to use
//  - override (default)
//  - merge
//

#import "GONMarkup.h"

typedef NS_ENUM(NSInteger, GONMarkupSimpleMergingStrategy) {
    GONMarkupSimpleMergingStrategyMergeAll                      = -1,
    GONMarkupSimpleMergingStrategyOverride                      = 0,

    GONMarkupSimpleMergingStrategyMergeAlignment                = 1 << 0,
    GONMarkupSimpleMergingStrategyMergeFirstLineHeadIndent      = 1 << 1,
    GONMarkupSimpleMergingStrategyMergeHeadIndent               = 1 << 2,
    GONMarkupSimpleMergingStrategyMergeTailIndent               = 1 << 3,
    GONMarkupSimpleMergingStrategyMergeLineBreakMode            = 1 << 4,
    GONMarkupSimpleMergingStrategyMergeMaximumLineHeight        = 1 << 5,
    GONMarkupSimpleMergingStrategyMergeMinimumLineHeight        = 1 << 6,
    GONMarkupSimpleMergingStrategyMergeLineSpacing              = 1 << 7,
    GONMarkupSimpleMergingStrategyMergeParagraphSpacing         = 1 << 8,
    GONMarkupSimpleMergingStrategyMergeParagraphSpacingBefore   = 1 << 9,
    GONMarkupSimpleMergingStrategyMergeBaseWritingDirection     = 1 << 10,
    GONMarkupSimpleMergingStrategyMergeLineHeightMultiple       = 1 << 11,
    GONMarkupSimpleMergingStrategyMergeTabStops                 = 1 << 12,
    GONMarkupSimpleMergingStrategyMergeDefaultTabInterval       = 1 << 13,
    GONMarkupSimpleMergingStrategyMergeHyphenationFactor        = 1 << 14
};

@interface GONMarkupSimple : GONMarkup
/* Class contructor, allowing to specify a merging strategy.
 * Use this constructor if this markup will update NSParagraphStyleAttributeName key
 * strategy can be a combinaison of GONMarkupSimpleMergingStrategy values to define per attribute merging strategy
 * "style" dictionary is intended to be the same as you may pass to configure an NSMutableAttributedString using -setAttributes:range: method
 */
+ (instancetype)simpleMarkup:(NSString *)tag style:(NSDictionary *)style mergingStrategy:(GONMarkupSimpleMergingStrategy)strategy;

/* Default class contructor, using override as default merging strategy
 * Use this constructor is this markup won't update NSParagraphStyleAttributeName key, will throw an exception otherwise
 * "style" dictionary is intended to be the same as you may pass to configure an NSMutableAttributedString using -setAttributes:range: method
 */
+ (instancetype)simpleMarkup:(NSString *)tag style:(NSDictionary *)style;

@property (nonatomic, copy, readonly) NSDictionary *style;
@end
