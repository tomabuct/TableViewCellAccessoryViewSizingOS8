//
//  View.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/19/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "View.h"

#import "ContentView.h"

#import <YLCollectionUtils/YLUITableView.h>

@interface View ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) ContentView *otherView;
@property (strong, nonatomic) ContentView *anotherView;

@end

@implementation View

- (instancetype)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor greenColor];
    [self addSubview:_scrollView];

    _anotherView = [[ContentView alloc] init];
    _anotherView.label.text = [@"" stringByPaddingToLength:10 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
    _anotherView.label2.text = [@"" stringByPaddingToLength:60 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
    _anotherView.layer.borderWidth = 1;
    _anotherView.layer.borderColor = [UIColor yellowColor].CGColor;
    [_scrollView addSubview:_anotherView];

    _tableView = [[YLUITableView alloc] initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    _tableView.scrollsToTop = NO;
    _tableView.layer.borderWidth = 1;
    _tableView.layer.borderColor = [UIColor blueColor].CGColor;
    [_scrollView addSubview:_tableView];

    _otherView = [[ContentView alloc] init];
    _otherView.label.text = [@"" stringByPaddingToLength:100 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
    _otherView.label2.text = [@"" stringByPaddingToLength:60 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
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
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_anotherView][_tableView]" options:0 metrics:nil views:views]];
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_anotherView]|" options:0 metrics:nil views:views]];

  _tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView(==self)]|" options:0 metrics:nil views:views]];

  _otherView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableView][_otherView]|" options:0 metrics:nil views:views]];
  [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_otherView]|" options:0 metrics:nil views:views]];
}

@end
