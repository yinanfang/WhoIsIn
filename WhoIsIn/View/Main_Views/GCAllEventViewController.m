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
    // Refresh control
    [self.eventTableViewController.refreshControl addTarget:self action:@selector(fetchEvents) forControlEvents:UIControlEventValueChanged];

}

- (void)fetchEvents
{
    DDLogVerbose(@"fetchEvents");
    // get sort method
    switch ([self.sortController.sortControl selectedSegmentIndex]) {
        case 0:
            self.eventTableViewController.eventSortMethod = EventSortedByDistance;
            break;
        case 1:
            self.eventTableViewController.eventSortMethod = EventSortedByUpComing;
            break;
        case 2:
            self.eventTableViewController.eventSortMethod = EventSortedByAllTime;
            break;
        default:
            break;
    }
    
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
    
    
    [GCAppViewModel getEventsWithParameter:parameter completion:^(BOOL succeeded) {
        if (succeeded) {
//            self.eventTableViewController.sortedEventsBasics = [GCAppViewModel sharedInstance].sortedEventsBasics;
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



@end
