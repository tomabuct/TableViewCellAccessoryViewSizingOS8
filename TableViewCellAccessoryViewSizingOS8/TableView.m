//
//  TableView.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/19/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "TableView.h"

@implementation TableView

- (CGSize)intrinsicContentSize {
  return self.contentSize;
}

- (void)setContentSize:(CGSize)contentSize {
  const CGSize oldContentSize = self.contentSize;

  super.contentSize = contentSize;

  if (!CGSizeEqualToSize(oldContentSize, self.contentSize)) [self invalidateIntrinsicContentSize];
}

@end
