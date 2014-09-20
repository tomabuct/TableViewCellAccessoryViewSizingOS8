//
//  UIBezierPath+YLUtils.h
//  YelpBizApp
//
//  Created by Allen Cheung on 7/7/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

@interface UIBezierPath (YLUtils)

/*!
 Creates and returns a new bezier path by circularly rounding the corners
 of a rectangle, so that the short edge of the rectangle is replaced by a
 half circle.  Note that this is not equivalent to bezierPathWithRoundedRect:
 cornerRadius:  See http://www.paintcodeapp.com/news/code-for-ios-7-rounded-rectangles
 @param rect CGRect
 @result A new path object with circular rounded corners
 */
+ (instancetype)yl_bezierPathWithCircularRoundedRect:(CGRect)rect;

/*!
 @abstract Creates a rectangular path by rounding the corners specified in the corners argument with a corner radius of cornerRadius
 @param rect CGRect rect to use as a blueprint for drawing the path. The path will be the shape of this rect
 @param corners UIRectCorner corners indicating which corners of the rect rectangle that should be rounded in the final path
 @param cornerRadius CGFloat cornerRadius radius of the corners to be rounded
 @result UIBezierPath that has been rounded based on the provided parameters
 @note This looks eerily similar to UIBezierPath's bezierPathWithRoundedRect:byRoundingCorners:cornerRadii:. However, this method doesn't use a spline to draw the path.
 */
+ (instancetype)yl_bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;

@end
