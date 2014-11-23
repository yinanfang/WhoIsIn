//
//  GCEventTableViewController.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCEventDetailViewController.h"

@interface GCEventTableViewController : UITableViewController

#pragma mark - Self
@property UIViewController *parentController;

@property GCEventSortMethod eventSortMethod;
@property NSMutableArray *sortedEventsBasics;
@property BOOL hasSortBar;

@property GCEventDetailViewController *eventDetailViewController;

#pragma mark - Method
- (instancetype)initWithParentController:(UIViewController *)controller;
- (void)reloadData;


@end
