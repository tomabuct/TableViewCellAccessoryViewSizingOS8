//
//  TableViewCell.h
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *label;

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic, getter=isSizingCell) BOOL sizingCell;

@end
