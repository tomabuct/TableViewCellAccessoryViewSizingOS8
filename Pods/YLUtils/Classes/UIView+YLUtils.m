//
//  UIView+YLUtils.m
//  YLUtils
//
//  Created by Tom Abraham on 5/9/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

#import "UIView+YLUtils.h"

void YLDisableTranslatesAutoresizingMaskIntoConstraints(NSDictionary *views) {
  for (UIView *view in [views allValues]) {
    view.translatesAutoresizingMaskIntoConstraints = NO;
  }
}

@interface YLVisibleAmbiguousLayoutException : NSException

- (instancetype)initWithTrace:(NSString *)trace;

@end

@implementation YLVisibleAmbiguousLayoutException

- (instancetype)initWithTrace:(NSString *)trace {
  NSString *const reason = [NSString stringWithFormat:@"Visible ambiguous layout detected:\n\n%@", trace];
  return [self initWithName:NSStringFromClass(self.class) reason:reason userInfo:nil];
}

@end

@implementation UIView (YLUtils)

#pragma mark Debugging Autolayout

- (NSString *)yl_shortDescription {
  return [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass(self.class), self];
}

- (void)yl_exceptionBreakpointOnVisibleAmbiguousLayout {
  if (!self.yl_hasVisibleAmbiguousLayout) return;

  @try {
    @throw [[YLVisibleAmbiguousLayoutException alloc] initWithTrace:self.yl_autolayoutTraceAmbiguousVisibleViews];
  } @catch (YLVisibleAmbiguousLayoutException *e) {
    NSLog(@"%@", e);
  }
}

- (BOOL)yl_isAmbiguouslyLaidOut {
  BOOL subviewsHaveAmbiguousLayout = NO;

  for (UIView *subview in self.subviews) {
    subviewsHaveAmbiguousLayout = subviewsHaveAmbiguousLayout || subview.hasAmbiguousLayout;
  }

  return self.hasAmbiguousLayout && !subviewsHaveAmbiguousLayout;
}

#pragma mark Recursively trace yl_hasVisibleAmbiguousLayout

- (BOOL)yl_hasVisibleAmbiguousLayout {
  BOOL hasVisibleAmbiguousLayout = NO;

  for (UIView *subview in self.subviews) {
    hasVisibleAmbiguousLayout = hasVisibleAmbiguousLayout || subview.yl_hasVisibleAmbiguousLayout;
  }

  // ignore ambiguous layout within views that are hidden
  return !self.hidden && (hasVisibleAmbiguousLayout || self.yl_isAmbiguouslyLaidOut);
}

- (NSString *)yl_autolayoutTraceAmbiguousVisibleViews {
  return [self _yl_autolayoutTraceAmbiguousVisibleViewsAtDepth:0];
}

- (NSString *)_yl_autolayoutTraceAmbiguousVisibleViewsAtDepth:(NSUInteger)depth {
  if (self.yl_hasVisibleAmbiguousLayout) {
    NSMutableArray *const trace = [[NSMutableArray alloc] init];

    // add trace for this view
    NSString *const indent = [self _yl_repeatString:@"|\t" times:depth];
    [trace addObject:[NSString stringWithFormat:@"%@%@ - AMBIGUOUS", indent, self.yl_shortDescription]];

    // add trace for each subview
    for (UIView *subview in self.subviews) {
      [trace addObject:[subview _yl_autolayoutTraceAmbiguousVisibleViewsAtDepth:depth + 1]];
    }

    // remove empty strings
    [trace removeObject:@""];

    // string together
    return [trace componentsJoinedByString:@"\n"];
  } else {
    return @"";
  }
}

#pragma mark Recursively trace needsUpdateConstraints

- (NSString *)yl_traceNeedsUpdateConstraints {
  return [self _yl_traceNeedsUpdateConstraintsAtDepth:0];
}

- (NSString *)_yl_traceNeedsUpdateConstraintsAtDepth:(NSUInteger)depth {
  NSMutableArray *const trace = [[NSMutableArray alloc] init];

  // add trace for this view
  NSString *const indent = [self _yl_repeatString:@"|\t" times:depth];
  [trace addObject:[NSString stringWithFormat:@"%@%@ - %@", indent, self.yl_shortDescription, self.needsUpdateConstraints ? @"YES" : @"NO"]];

  // add trace for each subview
  for (UIView *subview in self.subviews) {
    [trace addObject:[subview _yl_traceNeedsUpdateConstraintsAtDepth:depth + 1]];
  }

  // string together
  return [trace componentsJoinedByString:@"\n"];
}

#pragma mark Recursively trace layer.needsLayout

- (NSString *)yl_traceNeedsLayout {
  return [self _yl_traceNeedsLayoutAtDepth:0];
}

- (NSString *)_yl_traceNeedsLayoutAtDepth:(NSUInteger)depth {
  NSMutableArray *const trace = [[NSMutableArray alloc] init];

  // add trace for this view
  NSString *const indent = [self _yl_repeatString:@"|\t" times:depth];
  [trace addObject:[NSString stringWithFormat:@"%@%@ - %@", indent, self.yl_shortDescription, self.layer.needsLayout ? @"YES" : @"NO"]];

  // add trace for each subview
  for (UIView *subview in self.subviews) {
    [trace addObject:[subview _yl_traceNeedsLayoutAtDepth:depth + 1]];
  }

  // string together
  return [trace componentsJoinedByString:@"\n"];
}

- (NSString *)_yl_repeatString:(NSString *)string times:(NSUInteger)times {
  return [@"" stringByPaddingToLength:string.length * times withString:string startingAtIndex:0];
}

#pragma mark Repeatedly exercise ambiguity in layout

- (void)yl_exerciseAmbiguityInLayoutRecursively:(BOOL)recursive {
  [NSTimer scheduledTimerWithTimeInterval:.5
                                   target:self
                                 selector:@selector(exerciseAmbiguityInLayout)
                                 userInfo:nil
                                  repeats:YES];

  if (recursive) {
    for (UIView *const subview in self.subviews) {
      [subview yl_exerciseAmbiguityInLayoutRecursively:YES];
    }
  }
}

@end
