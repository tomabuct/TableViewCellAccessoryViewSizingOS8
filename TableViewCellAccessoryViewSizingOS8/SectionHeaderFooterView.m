//
//  SectionHeaderFooterView.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/21/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "SectionHeaderFooterView.h"

@implementation SectionHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    [self.contentView addSubview:_label];

    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *const views = NSDictionaryOfVariableBindings(_label);

  self.label.translatesAutoresizingMaskIntoConstraints = NO;
  [self.label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_label]-30-|"
                                                                           options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_label]-30-|"
                                                                           options:0 metrics:nil views:views]];
}

- (void)setWidth:(CGFloat)width {
  CGRect bounds = self.bounds;
  bounds.size.width = width;
  self.bounds = bounds;
}

- (CGFloat)width {
  return CGRectGetWidth(self.bounds);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self.contentView layoutIfNeeded];

  self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.bounds);

  [super layoutSubviews];
}
@end
