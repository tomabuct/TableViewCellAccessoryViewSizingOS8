//
//  ContentView.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/19/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _label = [[UILabel alloc] init];
    _label.layer.borderColor = [UIColor redColor].CGColor;
    _label.layer.borderWidth = 0.5;
    _label.font = [UIFont systemFontOfSize:8];
    _label.numberOfLines = 0;
    [self addSubview:_label];

    _label2 = [[UILabel alloc] init];
    _label2.layer.borderColor = [UIColor redColor].CGColor;
    _label2.layer.borderWidth = 0.5;
    _label2.numberOfLines = 0;
    _label.font = [UIFont systemFontOfSize:9];
    [self addSubview:_label2];

    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *const views = NSDictionaryOfVariableBindings(_label, _label2);

  self.label.translatesAutoresizingMaskIntoConstraints = NO;
  [self.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_label]-50-|"
                                                                           options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[_label]"
                                                                           options:0 metrics:nil views:views]];

  self.label2.translatesAutoresizingMaskIntoConstraints = NO;
  [self.label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_label2]-50-|"
                                                                           options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_label]-[_label2]-50-|"
                                                                           options:0 metrics:nil views:views]];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.bounds);
  self.label2.preferredMaxLayoutWidth = CGRectGetWidth(self.label2.bounds);

  [super layoutSubviews];

//  if (self.superview.superview.superview.superview) {
//    NSAssert(CGRectGetHeight(self.label.bounds) == self.label.intrinsicContentSize.height, @"bad layout!");
//  }
}


@end
