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
#import "ViewController.h"

NSString *const kCell = @"cell";

@interface TableViewDataSource ()

@property (assign, nonatomic) NSUInteger count;

@end

@implementation TableViewDataSource

- (instancetype)init {
  if (self = [super init]) {
    self.count = 4;
  }
  return self;
}

- (NSString *)tableView:(UITableView *)tableView reuseIdentifierForCellAtIndexPath:(NSIndexPath *)indexPath {
  return kCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (void)tableView:(UITableView *)tableView configureCell:(TableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
  cell.theContentView.label.text = [@"" stringByPaddingToLength:indexPath.row + 100 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.theContentView.label2.text = [@"" stringByPaddingToLength:indexPath.row + 30 withString:@"abcdefghijklmnopqrstuvwxyz" startingAtIndex:0];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.count++;
  [self.tableView reloadData];
  [self.viewController didSelectRow];
}


@end
