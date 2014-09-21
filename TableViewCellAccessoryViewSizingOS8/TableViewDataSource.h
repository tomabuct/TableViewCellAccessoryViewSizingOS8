//
//  TableViewDataSource.h
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/19/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import "YLUITableViewDataSource.h"

@class ViewController;

extern NSString *const kCell;
extern NSString *const kHeaderFooterView;

@interface TableViewDataSource : YLUITableViewDataSource

@property (weak, nonatomic) ViewController *viewController;

@property (weak, nonatomic) UITableView *tableView;

@end
