//
//  UIBezierPath+YLUtils.m
//  YelpBizApp
//
//  Created by Allen Cheung on 7/7/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "UIBezierPath+YLUtils.h"

@implementation UIBezierPath (YLUtils)


+ (instancetype)yl_bezierPathWithCircularRoundedRect:(CGRect)rect {
  CGFloat radius = MIN(rect.size.height, rect.size.width) / 2.0;
  return [self yl_bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadius:radius];
}

+ (instancetype)yl_bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius {
  UIBezierPath *path = [UIBezierPath bezierPath];
  
  // For each corner, we're going to check to see if we should round that corner, and then we either round it or draw lines for a hard corner. This method moves clockwise around the rect.
  
  // Start in the top left corner of the rect, one corner radius below the corner to start
  [path moveToPoint:CGPointMake(rect.origin.x, rect.origin.y + cornerRadius)];
  if (corners & UIRectCornerTopLeft) {
    [path addArcWithCenter:CGPointMake(path.currentPoint.x + cornerRadius, path.currentPoint.y) radius:cornerRadius startAngle:M_PI endAngle:3.0 * M_PI_2 clockwise:YES];
  } else {
    [path addLineToPoint:rect.origin];
    [path addLineToPoint:CGPointMake(path.currentPoint.x + cornerRadius, path.currentPoint.y)];
  }
  [path addLineToPoint:CGPointMake(path.currentPoint.x + (rect.size.width -  (2.0 *cornerRadius)), path.currentPoint.y)];
  
  if (corners & UIRectCornerTopRight) {
    [path addArcWithCenter:CGPointMake(path.currentPoint.x, path.currentPoint.y + cornerRadius) radius:cornerRadius startAngle:3.0 * M_PI_2 endAngle:0 clockwise:YES];
  } else {
    [path addLineToPoint:CGPointMake(path.currentPoint.x + cornerRadius, path.currentPoint.y)];
    [path addLineToPoint:CGPointMake(path.currentPoint.x, path.currentPoint.y + cornerRadius)];
  }
  [path addLineToPoint:CGPointMake(path.currentPoint.x, path.currentPoint.y + (rect.size.height -  (2.0 *cornerRadius)))];
  
  if (corners & UIRectCornerBottomRight) {
    [path addArcWithCenter:CGPointMake(path.currentPoint.x - cornerRadius, path.currentPoint.y) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
  } else {
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    [path addLineToPoint:CGPointMake(path.currentPoint.x - cornerRadius, path.currentPoint.y)];
  }
  [path addLineToPoint:CGPointMake(path.currentPoint.x - (rect.size.width -  (2.0 *cornerRadius)), path.currentPoint.y)];
  
  if (corners & UIRectCornerBottomLeft) {
    [path addArcWithCenter:CGPointMake(path.currentPoint.x, path.currentPoint.y - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
  } else {
    [path addLineToPoint:CGPointMake(path.currentPoint.x - cornerRadius, path.currentPoint.y)];
    [path addLineToPoint:CGPointMake(path.currentPoint.x, path.currentPoint.y - cornerRadius)];
  }
  
  // Closing the path will draw the final line
  [path closePath];
  
  return path;
}

@end
