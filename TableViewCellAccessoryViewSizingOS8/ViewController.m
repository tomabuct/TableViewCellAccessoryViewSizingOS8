//
//  ViewController.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"
#import "SectionHeaderFooterView.h"

static NSString *const kCell = @"cell";
static NSString *const kSectionHeaderFooterView = @"sectionHeaderFooterView";

NSString *const kOS7VersionString = @"7.0";
NSString *const kOS8VersionString = @"8.0";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) TableViewCell *sizingCell;
@property (strong, nonatomic) SectionHeaderFooterView *sizingHeaderFooterView;

@property (assign, nonatomic) NSUInteger count;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:kCell];
    [_tableView registerClass:[SectionHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kSectionHeaderFooterView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if ([self isOS8OrLater]) _tableView.estimatedRowHeight = 44;
    if ([self isOS8OrLater]) _tableView.estimatedSectionHeaderHeight = 44;

    _sizingCell = [_tableView dequeueReusableCellWithIdentifier:kCell];
    _sizingCell.sizingCell = YES;

    _sizingHeaderFooterView = [[SectionHeaderFooterView alloc] initWithReuseIdentifier:kSectionHeaderFooterView];

    _count = 10;
  }
  return self;
}

- (void)loadView {
  self.view = self.tableView;
}

#pragma mark UITableViewDataSource

- (void)tableView:(UITableView *)tableView configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  cell.label.text = [@"" stringByPaddingToLength:indexPath.row + 100 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView configureHeader:(SectionHeaderFooterView *)header inSection:(NSInteger)section {
  header.label.text = [@"" stringByPaddingToLength:section + 100 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  SectionHeaderFooterView *const sectionHeaderFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kSectionHeaderFooterView];
  [self tableView:tableView configureHeader:sectionHeaderFooterView inSection:section];
  return sectionHeaderFooterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewCell *const cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
  [self tableView:tableView configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.count++;

//  [tableView reloadData];
  [tableView beginUpdates];
  for (NSUInteger section = 0; section < [self numberOfSectionsInTableView:tableView]; section++) {
    [tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:self.count - 1 inSection:section] ]
                     withRowAnimation:UITableViewRowAnimationTop];
  }
  [tableView endUpdates];

  if (self.count % 2 == 0) {
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  static NSUInteger count = 0;
  if ([self isOS8OrLater]) {
    count++;
    return UITableViewAutomaticDimension;
  } else {
    count++;
    SectionHeaderFooterView *const header = self.sizingHeaderFooterView;
    [self tableView:tableView configureHeader:header inSection:section];

    header.width = CGRectGetWidth(tableView.bounds);
    [header layoutIfNeeded];

    CGSize sz = [header.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sz.height;
  }
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
