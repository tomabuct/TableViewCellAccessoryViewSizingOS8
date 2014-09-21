//
//  TableViewDataSource.m
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/19/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContentView.h"
#import "TableViewCell.h"
#import "TableViewDataSource.h"
#import "YLUITableViewDataSourceSubclass.h"
#import "ViewController.h"
#import  <YLCollectionUtils/YLUITableViewSectionHeaderFooterView.h>

NSString *const kCell = @"cell";
NSString *const kHeaderFooterView = @"headerFooterView";

@interface TableViewDataSource ()

@property (assign, nonatomic) NSUInteger count;

@end

@implementation TableViewDataSource

- (instancetype)init {
  if (self = [super init]) {
    self.count = 10;
  }
  return self;
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  return kCell;
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForHeaderInSection:(NSUInteger)section {
  return kHeaderFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (void)tableView:(UITableView *)tableView configureCell:(TableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
  cell.theContentView.label.text = [@"" stringByPaddingToLength:indexPath.row + 70 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.theContentView.label2.text = [@"" stringByPaddingToLength:indexPath.row + 40 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  [super tableView:tableView configureCell:cell forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView configureHeader:(YLUITableViewSectionHeaderFooterView *)headerView forSection:(NSUInteger)section {
  [super tableView:tableView configureHeader:headerView forSection:section];
  headerView.text = @"hiiii";
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.count++;

  if (self.count % 2 == 0) {
    [self.viewController didSelectRow];
    [self.tableView reloadData];
  } else {
    [self.tableView beginUpdates];
    for (NSUInteger i = 0; i < [self numberOfSectionsInTableView:tableView]; i++) {
      [self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForItem:self.count - 1 inSection:i] ]
                            withRowAnimation:UITableViewRowAnimationLeft];
    }
    [self.tableView endUpdates];
  }
}


@end
