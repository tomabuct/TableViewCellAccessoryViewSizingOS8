//
//  ViewController.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "ViewController.h"

#import "ContentView.h"
#import "TableViewCell.h"
#import "View.h"

NSString *const kOS7VersionString = @"7.0";
NSString *const kOS8VersionString = @"8.0";

static NSString *const kCell = @"cell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) View *containerView;

@property (strong, nonatomic) TableViewCell *sizingCell;

@property (assign, nonatomic) NSUInteger count;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    _containerView = [[View alloc] init];
    [_containerView.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:kCell];
    _containerView.tableView.delegate = self;
    _containerView.tableView.dataSource = self;

    _sizingCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCell];
    _sizingCell.sizingCell = YES;

    _count = 2;
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
  return self.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

#pragma mark UITableViewDelegate

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.count++;
  [self.containerView.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
  cell.theContentView.label.text = [@"" stringByPaddingToLength:indexPath.row + 100 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.theContentView.label2.text = [@"" stringByPaddingToLength:indexPath.row + 30 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
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
