//
//  View.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/19/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "View.h"

#import "TableView.h"

@interface View ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *otherView;
@property (strong, nonatomic) UIView *anotherView;

@end

@implementation View

- (instancetype)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor greenColor];
    [self addSubview:_scrollView];

    _anotherView = [[UIView alloc] init];
    _anotherView.layer.borderWidth = 1;
    _anotherView.layer.borderColor = [UIColor yellowColor].CGColor;
    [_scrollView addSubview:_anotherView];

    _tableView = [[TableView alloc] init];
    _tableView.scrollsToTop = NO;
    _tableView.layer.borderWidth = 1;
    _tableView.layer.borderColor = [UIColor blueColor].CGColor;
    [_scrollView addSubview:_tableView];

    _otherView = [[UIView alloc] init];
    _otherView.layer.borderWidth = 1;
    _otherView.layer.borderColor = [UIColor greenColor].CGColor;
    [_scrollView addSubview:_otherView];

    [self _installConstraints];
  }
  return self;
}

- (void)_installConstraints {
  NSDictionary *const views = NSDictionaryOfVariableBindings(self, _anotherView, _tableView, _otherView, _scrollView);

  _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics:nil views:views]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics:nil views:views]];

  _anotherView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_anotherView(200)][_tableView]" options:0 metrics:nil views:views]];
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_anotherView]|" options:0 metrics:nil views:views]];

  _tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView(==self)]|" options:0 metrics:nil views:views]];

  _otherView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableView][_otherView(200)]|" options:0 metrics:nil views:views]];
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_otherView]|" options:0 metrics:nil views:views]];
}

@end
