//
//  GONMarkupFontTraits.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 22/09/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupFontTraits.h"
#import "GONMarkup+private.h"

@interface GONMarkupFontTraits ()
// Data
@property (nonatomic, assign) UIFontDescriptorSymbolicTraits trait;
@end

@implementation GONMarkupFontTraits
#pragma mark - Constructor
+ (instancetype)fontTraitsMarkup:(NSString *)tag traits:(UIFontDescriptorSymbolicTraits )trait
{
    GONMarkupFontTraits *markup = [self markupForTag:tag];

    markup.trait = trait;

    return markup;
}


#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    // Look for current font
    UIFont *currentFont = [configurationDictionary objectForKey:NSFontAttributeName];
    if (!currentFont)
    {
        // No found defined, use default one with default size
        currentFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }

    UIFont *updatedFont = nil;

    // Check override block
    if (_overrideBlock)
    {
        // Try with override block
        updatedFont = _overrideBlock(currentFont);
    }

    // Check if font already has traits, and if override blocks didn't return a font
    if (!updatedFont)
    {
        // Update font to set trait
        UIFontDescriptor *fontDescriptor = currentFont.fontDescriptor;
        UIFontDescriptorSymbolicTraits fontTaits = fontDescriptor.symbolicTraits;

        if (!(fontTaits & _trait))
        {
            fontTaits |= _trait;
            updatedFont = [UIFont fontWithDescriptor:[fontDescriptor fontDescriptorWithSymbolicTraits:fontTaits]
                                                size:currentFont.pointSize];

            // Font may not exists, fallback
            // Note : In iOS7, if no fount is found, normal one will be returned. Since iOS8, nil will be returned
            if (!updatedFont || [currentFont isEqual:updatedFont])
            {
                if (self.parser.logLevel & GONMarkupParserLogLevelFonts)
                {
                    if (!_overrideBlock)
                        NSLog(@"%@ : No font found for <%@-%@> applying traits. Consider setting up <overrideBlock> to provide a font", [[self class] description], currentFont.familyName, currentFont.fontName);
                    else
                        NSLog(@"%@ : No font returned from overrideBlock for <%@-%@>. Consider seting up one", [[self class] description], currentFont.familyName, currentFont.fontName);
                }

                // Do not update font
                updatedFont = currentFont;
            }
        }
        else
        {
            // Font has already requested trait, so use it
            updatedFont = currentFont;
        }
    }

    // Check for font size
    if (updatedFont.pointSize != currentFont.pointSize)
    {
        // Build a new font with current size
        updatedFont = [UIFont fontWithDescriptor:[updatedFont fontDescriptor]
                                            size:currentFont.pointSize];
    }

    // Update configuration
    [configurationDictionary setObject:updatedFont
                                 forKey:NSFontAttributeName];
}

@end