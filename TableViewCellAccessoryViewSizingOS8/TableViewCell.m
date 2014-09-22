//
//  TableViewCell.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:10];
    _label.layer.borderColor = [UIColor redColor].CGColor;
    _label.layer.borderWidth = 0.5;
    _label.numberOfLines = 0;
    [self.contentView addSubview:_label];

    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *const views = @{ @"label": self.label };

  self.label.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                           options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                           options:0 metrics:nil views:views]];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self.contentView layoutIfNeeded];

  self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.bounds);

  [super layoutSubviews];

  for (UIView *view in self.subviews) {
    if ([view isKindOfClass:[UIButton class]]) {
      view.layer.borderColor = [UIColor redColor].CGColor;
      view.layer.borderWidth = 0.5;
    }
  }

}

- (void)setWidth:(CGFloat)width {
  CGRect bounds = self.bounds;
  bounds.size.width = width;
  self.bounds = bounds;
}

- (CGFloat)width {
  return CGRectGetWidth(self.bounds);
}

@end