//
//  ViewController.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"

static NSString *const kCell = @"cell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) TableViewCell *sizingCell;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    _tableView = [[UITableView alloc] init];
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:kCell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.estimatedRowHeight = 44;

    _sizingCell = [_tableView dequeueReusableCellWithIdentifier:kCell];
;
    _sizingCell.sizingCell = YES;
  }
  return self;
}

- (void)loadView {
  self.view = self.tableView;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewCell *const cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
  [self tableView:tableView configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 100;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewCell *const cell = self.sizingCell;
  [self tableView:tableView configureCell:cell atIndexPath:indexPath];

  cell.width = CGRectGetWidth(tableView.bounds);
  [cell layoutIfNeeded];
  
  CGSize sz = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  return sz.height + 0.5;
}

- (void)tableView:(UITableView *)tableView configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  cell.label.text = [@"" stringByPaddingToLength:indexPath.row + 1 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
