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
    // Initialize Variables
    
    // Event table view controller
    self.eventTableViewController = [[GCEventTableViewController alloc] initWithParentController:self];
    self.eventTableViewController.eventSortMethod = EventSortedByAllTime;
    self.eventTableViewController.hasSortBar = NO;
    self.eventTableViewController.sortedEventsBasics = [GCAppViewModel sharedInstance].sortedEventsBasicsMy;
    [self addChildViewController:self.eventTableViewController];
    [self.view addSubview:self.eventTableViewController.view];
    [self.eventTableViewController didMoveToParentViewController:self];
    [self.eventTableViewController updateViewConstraints];
    // Refresh control
    [self.eventTableViewController.refreshControl addTarget:self action:@selector(fetchEvents) forControlEvents:UIControlEventValueChanged];
    
}

- (void)fetchEvents
{
    DDLogVerbose(@"fetchEvents");
    // decide show expired
    
    // Init parameter
    NSMutableDictionary *parameter = [@{
                                        @"method": @"getActivities",
                                        @"showExpired": @"1",
                                        } mutableCopy];
    // Add parameter
    switch (self.eventTableViewController.eventSortMethod) {
        case EventSortedByDistance:
            DDLogVerbose(@"Sort method: EventSortedByDistance");
            parameter[@"sortBy"] = @"distance";
            parameter[@"origin"] = @"35.749087,-78.885771";
            break;
        case EventSortedByAllTime:
            DDLogVerbose(@"Sort method: EventSortedByAllTime");
            parameter[@"sortBy"] = @"timestamp";
            break;
        case EventSortedByUpComing:
            DDLogVerbose(@"Sort method: EventSortedByUpComing");
            parameter[@"sortBy"] = @"now";
            break;
        default:
            break;
    }
    
    
    [GCAppViewModel getEventsMyWithParameter:parameter completion:^(BOOL succeeded) {
        if (succeeded) {
            self.eventTableViewController.sortedEventsBasics = [GCAppViewModel sharedInstance].sortedEventsBasicsMy;
            [self.eventTableViewController reloadData];
        }
    }];
    
    
    //    if (!parameter) {
    //        // Fetch default activity list
    //
    //    }
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

- (void)viewDidAppear:(BOOL)animated
{
    // Auto renew event list once the view appears on first appearance
    if (!self.hasLoadDataBefore) {
        [self fetchEvents];
        self.hasLoadDataBefore = YES;
    }
    [super viewDidAppear:animated];
}

@end
