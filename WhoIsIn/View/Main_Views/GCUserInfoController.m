//
//  GCUserInfoController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCUserInfoController.h"

@implementation GCUserInfoController

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
    [self.eventTableViewController updateViewConstraints];
    // Refresh control
//    [self.eventTableViewController.refreshControl addTarget:self action:@selector(fetchEvents) forControlEvents:UIControlEventValueChanged];
}



@end
