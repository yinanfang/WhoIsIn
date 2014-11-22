//
//  GCMainTabController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/25/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCMainTabController.h"
#import "GCMainContainerViewController.h"

@implementation GCMainTabController

- (instancetype)initWithParentController:(GCMainContainerViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        // Background color is default to clear color and frame to fill the screen
        self.parentController = controller;
        
        // Empty Frame Initialization
//        UINavigationController *navigationController01 = [[UINavigationController alloc] init];
//        self.activityController = [[GCActivityController alloc] init];
//        [GCAppSetup configureNavigationViewController:self.activityController withNavigationTitle:@"Nearby Events"];
//        navigationController01.tabBarItem.title = @"All Events";
////        navigationController01.tabBarItem.image = [UIImage imageNamed:@"leaf"];
//        navigationController01.viewControllers = [NSArray arrayWithObjects:self.activityController, nil];
        
        UINavigationController *navigationController01 = [[UINavigationController alloc] init];
        self.allEventController = [[GCAllEventViewController alloc] init];
        [GCAppSetup configureNavigationViewController:self.allEventController withNavigationTitle:@"Nearby Events"];
        navigationController01.tabBarItem.title = @"All Events";
        //        navigationController01.tabBarItem.image = [UIImage imageNamed:@"leaf"];
        navigationController01.viewControllers = [NSArray arrayWithObjects:self.allEventController, nil];

        
        UINavigationController *navigationController02 = [[UINavigationController alloc] init];
        self.userInfoController = [[GCUserInfoController alloc] init];
        [GCAppSetup configureNavigationViewController:self.userInfoController withNavigationTitle:@"My Events"];
        navigationController02.tabBarItem.title = @"My Events";
        navigationController02.viewControllers = [NSArray arrayWithObjects:self.userInfoController, nil];
        
        UINavigationController *navigationController03 = [[UINavigationController alloc] init];
        self.accountController = [[GCAccountController alloc] init];
        [GCAppSetup configureNavigationViewController:self.accountController withNavigationTitle:@"Account Info"];
        navigationController03.tabBarItem.title = @"Account";
        navigationController03.viewControllers = [NSArray arrayWithObjects:self.accountController, nil];
        
        NSArray *allViewControllers = [[NSArray alloc] initWithObjects:navigationController01, navigationController02, navigationController03, nil];
        [self setViewControllers:allViewControllers];
                
    }
    return self;
}

@end
