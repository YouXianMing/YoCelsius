//
//  ARCGPathFromString.h
//
//  Created by Adrian Russell on 08/08/2014.
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

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

/**
 Creates a CGPath from a specified attributed string.
 @param attrString The attributed string to produce the path for. Must not be `nil`.
 @return A new CGPath that contains a path with paths for all the glyphs for specifed string.
 @discussion  This string will always be on a single line even if the string contains linebreaks.
 */
CGPathRef CGPathCreateSingleLineStringWithAttributedString(NSAttributedString *attrString);

/**
 Creates a CGPath from a specified attributed string that can span over multiple lines of text.
 @param attrString The attributed string to produce the path for. Must not be `nil`.
 @param maxWidth   The maximum width of a line, if a line when rendered is longer than this width then the line is broken to a new line. Must be greater than 0.
 @param maxHeight  The maximum height of the text block. Must be greater than 0.
 @return A new CGPath that contains a path with paths for all the glyphs for specifed string.
 */
CGPathRef CGPathCreateMultilineStringWithAttributedString(NSAttributedString *attrString, CGFloat maxWidth, CGFloat maxHeight);