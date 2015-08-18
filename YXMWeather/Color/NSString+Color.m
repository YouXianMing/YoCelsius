//
//  NSString+Color.m
//  NSStringColor
//
//  Created by Nicolas Goutaland on 04/04/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//
//  Color names : http://en.wikipedia.org/wiki/Web_colors

#import "NSString+Color.h"

@implementation NSString(Color)
#pragma mark - Class initialization
static __strong NSCache             *colorsCache;
static __strong NSMutableDictionary *dicCustomColors;
static __strong NSRegularExpression *hexadecimalStringRegex;
+ (void)load
{
    [super load];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorsCache            = [[NSCache alloc] init];
        dicCustomColors        = [[NSMutableDictionary alloc] init];
        hexadecimalStringRegex = [NSRegularExpression regularExpressionWithPattern:NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX
                                                                           options:0
                                                                             error:nil];

    });
}

#pragma mark - Web color
+ (UIColor *)webColorForKey:(NSString *)aWebColorName
{
    // Check cache first, to prevent unusful tests
    NSString *key = [aWebColorName lowercaseString];
    UIColor *color = [colorsCache objectForKey:key];
    if (color)
        return color;

    static dispatch_once_t onceToken;
    static __strong NSDictionary *dicWebColors = nil;
    dispatch_once(&onceToken, ^{
        dicWebColors =
        @{
          @"darkgreen":            @"006400" ,
          @"antiquewhite":         @"FAEBD7" ,
          @"aqua":                 @"00FFFF" ,
          @"aquamarine":           @"7FFFD4" ,
          @"azure":                @"F0FFFF" ,
          @"beige":                @"F5F5DC" ,
          @"bisque":               @"FFE4C4" ,
          @"black":                @"000000" ,
          @"blanchedalmond":       @"FFEBCD" ,
          @"blue":                 @"0000FF" ,
          @"blueviolet":           @"8A2BE2" ,
          @"brown":                @"A52A2A" ,
          @"burlywood":            @"DEB887" ,
          @"cadetblue":            @"5F9EA0" ,
          @"chartreuse":           @"7FFF00" ,
          @"chocolate":            @"D2691E" ,
          @"coral":                @"FF7F50" ,
          @"cornflowerblue":       @"6495ED" ,
          @"cornsilk":             @"FFF8DC" ,
          @"crimson":              @"DC143C" ,
          @"cyan":                 @"00FFFF" ,
          @"darkblue":             @"00008B" ,
          @"darkcyan":             @"008B8B" ,
          @"darkgoldenrod":        @"B8860B" ,
          @"darkgray":             @"A9A9A9" ,
          @"darkgreen":            @"006400" ,
          @"darkkhaki":            @"BDB76B" ,
          @"darkmagenta":          @"8B008B" ,
          @"darkolivegreen":       @"556B2F" ,
          @"darkorange":           @"FF8C00" ,
          @"darkorchid":           @"9932CC" ,
          @"darkred":              @"8B0000" ,
          @"darksalmon":           @"E9967A" ,
          @"darkseagreen":         @"8FBC8F" ,
          @"darkslateblue":        @"483D8B" ,
          @"darkslategray":        @"2F4F4F" ,
          @"darkturquoise":        @"00CED1" ,
          @"darkviolet":           @"9400D3" ,
          @"deeppink":             @"FF1493" ,
          @"deepskyblue":          @"00BFFF" ,
          @"dimgray":              @"696969" ,
          @"dodgerblue":           @"1E90FF" ,
          @"firebrick":            @"B22222" ,
          @"floralwhite":          @"FFFAF0" ,
          @"forestgreen":          @"228B22" ,
          @"fuchsia":              @"FF00FF" ,
          @"gainsboro":            @"DCDCDC" ,
          @"ghostwhite":           @"F8F8FF" ,
          @"gold":                 @"FFD700" ,
          @"goldenrod":            @"DAA520" ,
          @"gray":                 @"808080" ,
          @"green":                @"008000" ,
          @"greenyellow":          @"ADFF2F" ,
          @"honeydew":             @"F0FFF0" ,
          @"hotpink":              @"FF69B4" ,
          @"indianred":            @"CD5C5C" ,
          @"indigo":               @"4B0082" ,
          @"ivory":                @"FFFFF0" ,
          @"khaki":                @"F0E68C" ,
          @"lavender":             @"E6E6FA" ,
          @"lavenderblush":        @"FFF0F5" ,
          @"lawngreen":            @"7CFC00" ,
          @"lemonchiffon":         @"FFFACD" ,
          @"lightblue":            @"ADD8E6" ,
          @"lightcoral":           @"F08080" ,
          @"lightcyan":            @"E0FFFF" ,
          @"lightgoldenrodyellow": @"FAFAD2" ,
          @"lightgreen":           @"90EE90" ,
          @"lightgrey":            @"D3D3D3" ,
          @"lightpink":            @"FFB6C1" ,
          @"lightsalmon":          @"FFA07A" ,
          @"lightseagreen":        @"20B2AA" ,
          @"lightskyblue":         @"87CEFA" ,
          @"lightslategray":       @"778899" ,
          @"lightsteelblue":       @"B0C4DE" ,
          @"lightyellow":          @"FFFFE0" ,
          @"lime":                 @"00FF00" ,
          @"limegreen":            @"32CD32" ,
          @"linen":                @"FAF0E6" ,
          @"magenta":              @"FF00FF" ,
          @"maroon":               @"800000" ,
          @"mediumaquamarine":     @"66CDAA" ,
          @"mediumblue":           @"0000CD" ,
          @"mediumorchid":         @"BA55D3" ,
          @"mediumpurple":         @"9370DB" ,
          @"mediumseagreen":       @"3CB371" ,
          @"mediumslateblue":      @"7B68EE" ,
          @"mediumspringgreen":    @"00FA9A" ,
          @"mediumturquoise":      @"48D1CC" ,
          @"mediumvioletred":      @"C71585" ,
          @"midnightblue":         @"191970" ,
          @"mintcream":            @"F5FFFA" ,
          @"mistyrose":            @"FFE4E1" ,
          @"moccasin":             @"FFE4B5" ,
          @"navajowhite":          @"FFDEAD" ,
          @"navy":                 @"000080" ,
          @"oldlace":              @"FDF5E6" ,
          @"olive":                @"808000" ,
          @"olivedrab":            @"6B8E23" ,
          @"orange":               @"FFA500" ,
          @"orangered":            @"FF4500" ,
          @"orchid":               @"DA70D6" ,
          @"palegoldenrod":        @"EEE8AA" ,
          @"palegreen":            @"98FB98" ,
          @"paleturquoise":        @"AFEEEE" ,
          @"palevioletred":        @"DB7093" ,
          @"papayawhip":           @"FFEFD5" ,
          @"peachpuff":            @"FFDAB9" ,
          @"peru":                 @"CD853F" ,
          @"pink":                 @"FFC0CB" ,
          @"plum":                 @"DDA0DD" ,
          @"powderblue":           @"B0E0E6" ,
          @"purple":               @"800080" ,
          @"red":                  @"FF0000" ,
          @"rosybrown":            @"BC8F8F" ,
          @"royalblue":            @"4169E1" ,
          @"saddlebrown":          @"8B4513" ,
          @"salmon":               @"FA8072" ,
          @"sandybrown":           @"F4A460" ,
          @"seagreen":             @"2E8B57" ,
          @"seashell":             @"FFF5EE" ,
          @"sienna":               @"A0522D" ,
          @"silver":               @"C0C0C0" ,
          @"skyblue":              @"87CEEB" ,
          @"slateblue":            @"6A5ACD" ,
          @"slategray":            @"708090" ,
          @"snow":                 @"FFFAFA" ,
          @"springgreen":          @"00FF7F" ,
          @"steelblue":            @"4682B4" ,
          @"tan":                  @"D2B48C" ,
          @"teal":                 @"008080" ,
          @"thistle":              @"D8BFD8" ,
          @"tomato":               @"FF6347" ,
          @"turquoise":            @"40E0D0" ,
          @"violet":               @"EE82EE" ,
          @"wheat":                @"F5DEB3" ,
          @"white":                @"FFFFFF" ,
          @"whitesmoke":           @"F5F5F5" ,
          @"yellow":               @"FFFF00" ,
          @"yellowgreen":          @"9ACD32" };
    });

    // Try to retrieve webcolor code
    NSString *colorCode = [dicWebColors objectForKey:key];
    if (colorCode)
    {
        // Compute color
        color = [colorCode colorFromRGBcode];

        // Hold color
        [colorsCache setObject:color
                        forKey:key];
    }

    return color;
}

#pragma mark - Custom colors
+ (void)registerColor:(UIColor *)aColor withKey:(NSString *)aKey
{
    NSString *key = [aKey lowercaseString];

    [dicCustomColors setObject:aColor
                        forKey:key];
    [colorsCache removeObjectForKey:key];
}

+ (void)clearRegisteredColorForKey:(NSString *)aKey
{
    NSString *key = [aKey lowercaseString];

    [dicCustomColors removeObjectForKey:key];
    [colorsCache removeObjectForKey:key];
}

+ (void)registerColors:(NSDictionary *)colors
{
    NSMutableDictionary *updatedDic = [[NSMutableDictionary alloc] init];
    UIColor *color;
    id value;
    NSString *lowercaseKey;
    for (NSString *key in colors)
    {
        // Compute lowercase key
        lowercaseKey = [key lowercaseString];

        value = [colors objectForKey:key];
        if ([value isKindOfClass:[UIColor class]])
        {
            [updatedDic setObject:value
                           forKey:lowercaseKey];
            [colorsCache removeObjectForKey:lowercaseKey];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            // Try to extract color
            color = [value representedColor];
            if (color)
            {
                [updatedDic setObject:color
                               forKey:lowercaseKey];
                [colorsCache removeObjectForKey:lowercaseKey];
            }
        }
    }

    // Add custom colors
    [dicCustomColors addEntriesFromDictionary:updatedDic];
}

+ (UIColor *)registeredColorForKey:(NSString *)aKey
{
    // Check cache first, to prevent unusful tests
    NSString *key = [aKey lowercaseString];
    UIColor *color = [colorsCache objectForKey:key];
    if (color)
        return color;

    // Try to retrieve color
    color = [dicCustomColors objectForKey:key];
    if (color)
    {
        // Hold color in cache
        [colorsCache setObject:color
                        forKey:self];
    }

    return color;
}

#pragma mark - Color
- (UIColor *)colorFromRGBcode
{
    UIColor *color = [colorsCache objectForKey:self];
    if (color)
        return color;

	unsigned int colorRGBhexaCode = 0;

	// Scan hex number
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	[scanner scanHexInt:&colorRGBhexaCode];

	// Extract color components
    unsigned int redColor   = (colorRGBhexaCode >> 16);
    unsigned int greenColor = (colorRGBhexaCode >>  8) & 0x00FF;
    unsigned int blueColor  =  colorRGBhexaCode        & 0x0000FF;

	// Create result color
	color = [UIColor colorWithRed:redColor/255.0 green:greenColor/255.0 blue:blueColor/255.0 alpha:1.0];

    // Update cache
    if (color)
    {
        [colorsCache setObject:color
                        forKey:self];
    }

	return color;
}

- (UIColor *)colorFromRGBAcode
{
    UIColor *color = [colorsCache objectForKey:self];
    if (color)
        return color;

	unsigned int colorRGBhexaCode = 0;

	// Scan hex number
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	[scanner scanHexInt:&colorRGBhexaCode];

	// Extract color components
    unsigned int redColor   = (colorRGBhexaCode >> 24);
    unsigned int greenColor = (colorRGBhexaCode >> 16) & 0x00FF;
    unsigned int blueColor  = (colorRGBhexaCode >>  8) & 0x0000FF;
    unsigned int alphaColor =  colorRGBhexaCode        & 0x000000FF;

	// Create result color
	color = [UIColor colorWithRed:redColor/255.0f green:greenColor/255.0f blue:blueColor/255.0f alpha:alphaColor/255.0f];

    // Update cache
    if (color)
    {
        [colorsCache setObject:color
                        forKey:self];
    }

	return color;
}

- (UIColor *)colorFromName
{
    UIColor *color = [colorsCache objectForKey:self];
    if (color)
        return color;

    // Check custom colors
    color = [[self class] registeredColorForKey:self];
    if (color)
        return color;

    // Check for web color
    color = [[self class] webColorForKey:self];
    if (color)
        return color;

    SEL sel = NSSelectorFromString(self);
    if ([UIColor respondsToSelector:sel])
    {
        color = [UIColor performSelector:sel];
    }
    else
    {
        SEL selColor = NSSelectorFromString([self stringByAppendingString:@"Color"]);
        if ([UIColor respondsToSelector:selColor])
            color = [UIColor performSelector:selColor];
    }

    // Update cache
    if (color)
    {
        [colorsCache setObject:color
                        forKey:self];
    }

    return color;
}

- (UIColor *)representedColor
{
    // Check cache first, to prevent unusful tests
    UIColor *color = [colorsCache objectForKey:self];
    if (color)
        return color;

    // Hexadecimal code, starting with #
    if ([self rangeOfString:NSString_Color_HEXADECIMAL_PREFIX].location == 0)
    {
        // RGB Code
        if (self.length == 7)
            return [[self substringFromIndex:1] colorFromRGBcode];

        // RGBA Code
        return [[self substringFromIndex:1] colorFromRGBAcode];
    }

    // Hexadecimal code without #
    NSRange firstMatch = [hexadecimalStringRegex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (firstMatch.location == 0 && firstMatch.length == self.length)
    {
        if (self.length == 6)
            return [self colorFromRGBcode];

        return [self colorFromRGBAcode];
    }

    // Final test, check for selector name, web colors
    return [self colorFromName];
}
@end