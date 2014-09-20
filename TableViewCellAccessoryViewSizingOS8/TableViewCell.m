//
//  TableViewCell.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "TableViewCell.h"
#import "ContentView.h"

@interface TableViewCell ()

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _theContentView = [[ContentView alloc] init];
    _theContentView.layer.borderColor = [UIColor redColor].CGColor;
    _theContentView.layer.borderWidth = 0.5;
    [self.contentView addSubview:_theContentView];

    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *const views = NSDictionaryOfVariableBindings(_theContentView);

  self.theContentView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_theContentView]-5-|"
                                                                           options:0 metrics:nil views:views]];
  [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_theContentView]-5-|"
                                                                           options:0 metrics:nil views:views]];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
//  self.width = targetSize.width;

//  NSMutableArray *layoutHostConstraints = [[NSMutableArray alloc] init];
//  for (NSLayoutConstraint *c in self.contentView.constraints) {
//    if ([c.identifier hasPrefix:@"UIView-Encapsulated-Layout"]) {
//      [layoutHostConstraints addObject:c];
//    }
//  }
//  [self.contentView removeConstraints:layoutHostConstraints];

//  [self layoutIfNeeded];

//  [self.contentView addConstraints:layoutHostConstraints];

  return [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
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