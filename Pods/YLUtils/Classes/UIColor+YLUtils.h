//
//  UIColor+YLUtils.h
//  YLUtils
//
//  Created by Alexander Haefner on 4/16/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

@interface UIColor (YLUtils)

/*!
 Returns a UIColor created from the supplied hexadecimal value, interpreted as RGB.
 @param hex A hexadecimal value representing a color in RGB format
 @param alpha Alpha value from 0.0 to 1.0
 @return UIColor
 */
+ (UIColor *)yl_colorWithRGBHex:(NSUInteger)hex alpha:(CGFloat)alpha;

@end
