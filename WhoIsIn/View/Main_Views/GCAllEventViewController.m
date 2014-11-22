//
//  GCAllEventViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAllEventViewController.h"

@implementation GCAllEventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize Variables
    
    // Sort Control
    self.sortController = [[GCSortControlViewController alloc] initWithParentController:self];
    [self addChildViewController:self.sortController];
    [self.view addSubview:self.sortController.view];
    [self.sortController didMoveToParentViewController:self];
    [self.sortController updateViewConstraints];
    
    // Event table view controller
    self.eventTableViewController = [[GCEventTableViewController alloc] initWithParentController:self];
    [self addChildViewController:self.eventTableViewController];
    [self.view addSubview:self.eventTableViewController.view];
    [self.eventTableViewController didMoveToParentViewController:self];
    [self.eventTableViewController updateViewConstraints];
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
