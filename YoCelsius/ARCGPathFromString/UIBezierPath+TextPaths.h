//
//  UIBezierPath+TextPaths.h
//
//  Created by Adrian Russell on 11/10/2012.
//  Copyright (c) 2014 Adrian Russell. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import <UIKit/UIKit.h>


@interface UIBezierPath (TextPaths)

/** @name Path from NSString */

/**
 Create a bezier path for a specified string rendered with a specified font.
 @param string The string to produce the path for. Must not be `nil`.
 @param font   The font to use for producing the string glyphs. Must not be `nil`.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string.
 @discussion If either the string or font paramter are set to `nil` then the method will return `nil`. If the string contains any newline characters they will be ingored and the string will be rendered on a single line.
*/
+ (UIBezierPath *)pathForString:(NSString *)string
                       withFont:(UIFont *)font;

/**
 Create a bezier path for a specified string that consumes multiple lines rendered with a specified font.
 @param string    The string to produce the path for. Must not be `nil`.
 @param font      The font to use for producing the string glyphs. Must not be `nil`.
 @param maxWidth  The maximum width of a line, if a line when rendered is longer than this width then the line is broken to a new line. Must be greater than 0.
 @param alignment The alignment of text. This method supports Left, Center, Right & Justified alignment; Natural will be treated as Left.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string.
 */
+ (UIBezierPath *)pathForMultilineString:(NSString *)string
                                withFont:(UIFont *)font
                                maxWidth:(CGFloat)maxWidth
                           textAlignment:(NSTextAlignment)alignment;



/** @name Path from NSAttributedString */

/**
 Create a bezier path for a specified attributed string.
 @param string The string to produce the path for. Must not be `nil`.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string. If the input string is `nil` then `nil` is returned.
 @discussion If the string contains any newline characters they will be ingored and the string will be rendered on a single line.
 */
+ (UIBezierPath *)pathForAttributedString:(NSAttributedString *)string;


/**
 Create a bezier path for a specified attributed string that consumes multiple lines.
 @param string   The string to produce the path for. Must not be `nil`.
 @param maxWidth The maximum width of a line, if a line when rendered is longer than this width then the line is broken to a new line. Must be greater than 0.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string.
 */
+ (UIBezierPath *)pathForMultilineAttributedString:(NSAttributedString *)string
                                          maxWidth:(CGFloat)maxWidth;

@end
