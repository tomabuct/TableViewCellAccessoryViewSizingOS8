//
//  TableViewCell.h
//  TableViewCellAccessoryViewSizingOS8
//
//  Created by Tom Abraham on 9/18/14.
//  Copyright (c) 2014 tomabuct. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <YLCollectionUtils/YLUITableViewCell.h>

@class ContentView;

@interface TableViewCell : YLUITableViewCell

@property (strong, nonatomic) ContentView *theContentView;

@end
