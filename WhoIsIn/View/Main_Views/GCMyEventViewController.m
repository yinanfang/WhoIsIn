//
//  GCMyEventViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCMyEventViewController.h"

@implementation GCMyEventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DDLogInfo(@"====================  Entered User Info container controller  ====================");
    
    // Initialize Variables
    
    // Event table view controller
    self.eventTableViewController = [[GCEventTableViewController alloc] initWithParentController:self];
    [self addChildViewController:self.eventTableViewController];
    [self.view addSubview:self.eventTableViewController.view];
    [self.eventTableViewController didMoveToParentViewController:self];
    self.eventTableViewController.eventSortMethod = EventSortedByDistance;
    self.eventTableViewController.hasSortBar = NO;
    [self.eventTableViewController updateViewConstraints];
    // Refresh control
    //    [self.eventTableViewController.refreshControl addTarget:self action:@selector(fetchEvents) forControlEvents:UIControlEventValueChanged];}
}

- (void)viewWillAppear:(BOOL)animated
{
    DDLogInfo(@"viewWillAppear");
    // Navigation Control
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
    
    // Reload table view
    //    NSLog(@"reload..");
    //    [self.surveyScrollView.orderTableView reloadData];
    
    [super viewWillAppear:animated];
}

@end
