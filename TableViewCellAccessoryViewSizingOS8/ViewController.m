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
#import "TableViewDataSource.h"
#import "View.h"
#import <YLCollectionUtils/YLUITableViewSectionHeaderFooterView.h>

@interface ViewController ()

@property (strong, nonatomic) View *containerView;

@property (strong, nonatomic) TableViewDataSource *dataSource;

@end

@implementation ViewController

- (instancetype)init {
  if (self = [super init]) {
    _dataSource = [[TableViewDataSource alloc] init];
    _dataSource.viewController = self;

    _containerView = [[View alloc] init];
    [_containerView.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:kCell];
    [_containerView.tableView registerClass:[YLUITableViewSectionHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kHeaderFooterView];
    _containerView.tableView.delegate = _dataSource;
    _containerView.tableView.dataSource = _dataSource;
    _containerView.tableView.estimatedRowHeight = 45;
    _containerView.tableView.estimatedSectionHeaderHeight = 50;

    _dataSource.tableView = _containerView.tableView;
  }
  return self;
}

- (void)loadView {
  self.view = self.containerView;
}

- (void)didSelectRow {
  [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

@end
