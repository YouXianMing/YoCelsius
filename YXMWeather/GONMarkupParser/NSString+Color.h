//
//  NSString+Color.h
//  NSStringColor
//
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//  Created by Nicolas Goutaland on 04/04/14.
//
//  Category used to create a color from a string.
//  Use an internal cache to reuse colors
//  When using hexadecimal string represntation, you can prefix it with NSString_Color_HEXADECIMAL_PREFIX to speed up test
//  This class also support web colors code, as defined here : http://en.wikipedia.org/wiki/Web_colors
//
//  representedColor is a convenient method, to be used when you don't know color format.
//  You can also use colorFromRGBcode colorFromRGBAcode or colorFromName directly
//
//  Another useful feature is the ability to define custom color codes
//
//  Change log
//  1.1  : Added convenient method to register custom colors
//  1.0  : Initial release

#define NSString_Color_HEXADECIMAL_PREFIX                 @"#"
#define NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX     @"[0-9A-Fa-f]{6,8}"

@interface NSString(Color)
/* Allows you to register a custom color.
 * Color could be retrieved from registeredColorForCode, colorFromName or represented method
 *
 * When trying to retrieve color from a stirng, registred colors will be checked first
 * This method is really helpful to define colors used by your application.
 * For example, you can define a titleTextForegroundColor in a configuration file and register it at loading
 * You will just have to update its color definition in order to update it through all application
 *
 * Be careful, keys are case insensitive !
 */
+ (void)registerColor:(UIColor *)aColor withKey:(NSString *)aKey;

/* Register a bunch of custom colors
 * Useful when loading custom colors configuration from a PLIST
 * Each value can be either UIColor object or strings, that will be transformed in UIColor objects using representedColor method
 */
+ (void)registerColors:(NSDictionary *)colors;

/* Remove registered color
 * Be careful, keys are case insensitive !
 */
+ (void)clearRegisteredColorForKey:(NSString *)aKey;

/* Retrieve color registered with given key
 * Be careful, keys are case insensitive !
 */
+ (UIColor *)registeredColorForKey:(NSString *)aKey;

/* Retrieve web color using lowercase comparison */
+ (UIColor *)webColorForKey:(NSString *)aWebColorName;

/* Return color from string, assuming it is an Hexadecimal number representation, without leading character 
 * If string isn't a valid hexadecimal color representation, a color object will still be returned, but with incorrect values
 */
- (UIColor *)colorFromRGBcode;

/* Return color from string, assuming it is an Hexadecimal number representation with alpha component, without leading character
 * If string isn't a valid hexadecimal color representation, a color object will still be returned, but with incorrect values
 */
- (UIColor *)colorFromRGBAcode;

/* Return color from string, assuming it is a color name defined in UIColor class or a registered color name.
 * First string will be check on registeredColors list. If a color is found, it will be returned.
 * Next, check for web color, using lowercase comparison
 * If no matching found, check for selector on UIColor
 * If no matching on selector in UIColor found, retry adding "Color" suffix to string
 * If no color is found, nil is returned
 */
- (UIColor *)colorFromName;

/* Return color from string.
 * - First string will be check on registeredColors list. If a color is found, it will be returned.
 * - Otherwise, if string start with NSString_Color_HEXADECIMAL_PREFIX, it will be considered as en hexadecimal string
 *      - If length is 7, colorFromRGBcode will be used on substring starting at 1
 *      - Else, colorFromRGBAcode will be used on substring starting at 1
 * - Else, string be be checked through NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX to check if its an hexadecimal number
 *      - If matching
 *          - If length is 6, colorFromRGBcode will be used on string
 *          - Else, colorFromRGBAcode will be used on string
 * - Finally, string will be assumed to be a color name, so colorFromName will be used on string
 */
- (UIColor *)representedColor;
@end
