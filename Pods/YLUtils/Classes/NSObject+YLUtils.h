//
//  NSObject+YLUtils.m
//  YLUtils
//
//  Created by Tom Abraham on 9/12/14.
//  Copyright (c) 2014 Yelp. All rights reserved.
//

@interface NSObject (YLUtils)

#pragma mark < OS8 Compatibility

- (BOOL)yl_respondsToOS8Selector:(SEL)selector;

@end