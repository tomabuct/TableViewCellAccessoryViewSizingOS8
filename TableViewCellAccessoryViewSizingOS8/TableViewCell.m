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

    _label2 = [[UILabel alloc] init];
    _label2.font = [UIFont systemFontOfSize:9];
    _label2.layer.borderColor = [UIColor redColor].CGColor;
    _label2.layer.borderWidth = 0.5;
    _label2.numberOfLines = 0;
    [self.contentView addSubview:_label2];

    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *const views = @{ @"label": self.label, @"label2": self.label2 };

  self.label.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[label]-50-|"
                                                                           options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[label]"
                                                                           options:0 metrics:nil views:views]];

  self.label2.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[label2]-50-|"
                                                                           options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-[label2]-50-|"
                                                                           options:0 metrics:nil views:views]];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
  return [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self.contentView layoutIfNeeded];

  self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.bounds);
  self.label2.preferredMaxLayoutWidth = CGRectGetWidth(self.label2.bounds);

  [super layoutSubviews];

//  if (self.superview) {
//    NSAssert(CGRectGetHeight(self.label.bounds) == self.label.intrinsicContentSize.height, @"bad layout!");
//  }
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