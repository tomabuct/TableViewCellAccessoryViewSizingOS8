//
//  UIColor+YLUtils.m
//  YLUtils
//
//  Created by Alexander Haefner on 4/16/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "UIColor+YLUtils.h"

@implementation UIColor (YLUtils)

+ (UIColor *)yl_colorWithRGBHex:(NSUInteger)hex alpha:(CGFloat)alpha {
  return [UIColor colorWithRed:((hex >> 16) & 0xff)/255.0 green:((hex >> 8) & 0xff)/255.0 blue:(hex & 0xff)/255.0 alpha:alpha];
}

@end
