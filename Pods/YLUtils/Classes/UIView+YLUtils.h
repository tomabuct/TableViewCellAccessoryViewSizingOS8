//
//  UIView+YLUtils.h
//  YLUtils
//
//  Created by Tom Abraham on 5/9/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

@interface UIView (YLUtils)

void YLDisableTranslatesAutoresizingMaskIntoConstraints(NSDictionary *views);

#pragma mark Debugging Autolayout

#ifdef DEBUG

//! @result A short description of the view. e.g.: <YPFunkyView: 0xDEADD00D>
- (NSString *)yl_shortDescription;

//! @result YES, if self has ambiguous layout but no subviews do
- (BOOL)yl_isAmbiguouslyLaidOut;

/*! @result Trace of the view hierarchy involving ambiguously laid out visible views
 *
 *  e.g. <YPSignUpView: 0xe54f5a0> - AMBIGUOUS
 *       | <UIView: 0xe52e6b0> - AMBIGUOUS
 *       | | <YKUIGroupTextField: 0xe54d0e0> - AMBIGUOUS
 *       | | | <UILabel: 0xe54d520> - AMBIGUOUS
 *       | | <YKUIGroupTextField: 0xe5408f0> - AMBIGUOUS
 *       | | | <UILabel: 0xe595e60> - AMBIGUOUS
 */
- (NSString *)yl_autolayoutTraceAmbiguousVisibleViews;

/*! @result Trace of the view hierarchy with layer.needsLayout flag alongside
 *
 *  e.g. <UIView: 0x8c39a50> - YES
 *       | <ViewA: 0x8c368a0> - NO
 *       | | <ViewB: 0x8c37040> - NO
 *       | | | <UILabel: 0x8c375f0> - NO
 *       | | <UIView: 0x8c393e0> - NO
 */
- (NSString *)yl_traceNeedsLayout;

/*! @result Trace of the view hierarchy with needsUpdateConstraints flag alongside
 *
 *  e.g. <UIView: 0x8c39a50> - YES
 *       | <ViewA: 0x8c368a0> - NO
 *       | | <ViewB: 0x8c37040> - NO
 *       | | | <UILabel: 0x8c375f0> - NO
 *       | | <UIView: 0x8c393e0> - NO
 */
- (NSString *)yl_traceNeedsUpdateConstraints;

//! Throws and catches an exception on ambiguous layout, and NSLogs yk_autolayoutTraceAmbiguousVisibleViews
- (void)yl_exceptionBreakpointOnVisibleAmbiguousLayout;

//! @result YES, if any view in the hierarchy rooted at this view is ambiguously laid out and visible; NO, otherwise
- (BOOL)yl_hasVisibleAmbiguousLayout;

//! Keeps exercising ambiguity in layout every half a second
- (void)yl_exerciseAmbiguityInLayoutRecursively:(BOOL)recursively;

#endif

@end
