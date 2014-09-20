//
//  ViewController.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"
#import "View.h"

NSString *const kOS7VersionString = @"7.0";
NSString *const kOS8VersionString = @"8.0";

static NSString *const kCell = @"cell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) View *containerView;

@property (strong, nonatomic) TableViewCell *sizingCell;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    _containerView = [[View alloc] init];
    [_containerView.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:kCell];
    _containerView.tableView.delegate = self;
    _containerView.tableView.dataSource = self;
    _containerView.tableView.estimatedRowHeight = 50;

    _sizingCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCell];
    _sizingCell.sizingCell = YES;
  }
  return self;
}

- (void)loadView {
  self.view = self.containerView;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewCell *const cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
  [self tableView:tableView configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 5;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSUInteger count = 0;
  if ([self isOS8OrLater]) {
    count++;
    return UITableViewAutomaticDimension;
  } else {
    count++;
    TableViewCell *const cell = self.sizingCell;
    [self tableView:tableView configureCell:cell atIndexPath:indexPath];

    cell.width = CGRectGetWidth(tableView.bounds);
    [cell layoutIfNeeded];

    CGSize sz = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sz.height + 0.5;
  }
}

- (void)tableView:(UITableView *)tableView configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  cell.label.text = [@"" stringByPaddingToLength:indexPath.row + 100 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark Utils

- (NSString *)_systemVersion {
  static NSString *SystemVersion = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SystemVersion = [[UIDevice currentDevice] systemVersion];
  });
  return SystemVersion;
}

- (BOOL)isOS7OrLater {
  return [self systemVersionIsGreaterThan:kOS7VersionString inclusive:YES];
}

- (BOOL)isOS8OrLater {
  return [self systemVersionIsGreaterThan:kOS8VersionString inclusive:YES];
}

- (BOOL)systemVersionIsEqualTo:(NSString *)version {
  return [[self _systemVersion] compare:version options:NSNumericSearch] == NSOrderedSame;
}

- (BOOL)systemVersionIsGreaterThan:(NSString *)version inclusive:(BOOL)inclusive {
  NSComparisonResult comparisonResult = [[self _systemVersion] compare:version options:NSNumericSearch];
  if (inclusive) {
    return comparisonResult != NSOrderedAscending;
  } else {
    return comparisonResult == NSOrderedDescending;
  }
}

@end
