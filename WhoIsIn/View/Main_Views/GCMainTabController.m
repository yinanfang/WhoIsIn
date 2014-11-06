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
        UINavigationController *navigationController01 = [UINavigationController new];
        self.activityController = [GCActivityController new];
        self.activityController.navigationItem.title = @"Nearby Activities";
        navigationController01.tabBarItem.title = @"Activity";
//        navigationController01.tabBarItem.image = [UIImage imageNamed:@"leaf"];
        navigationController01.viewControllers = [NSArray arrayWithObjects:self.activityController, nil];
        
        UINavigationController *navigationController02 = [UINavigationController new];
        self.userInfoController = [GCUserInfoController new];
        self.userInfoController.navigationItem.title = @"Signed up activities";
        navigationController02.tabBarItem.title = @"My Activity";
        navigationController02.viewControllers = [NSArray arrayWithObjects:self.userInfoController, nil];
        
        UINavigationController *navigationController03 = [UINavigationController new];
        self.accountController = [GCAccountController new];
        self.accountController.navigationItem.title = @"Account Info";
        navigationController03.tabBarItem.title = @"Account";
        navigationController03.viewControllers = [NSArray arrayWithObjects:self.accountController, nil];
        
        NSArray *allViewControllers = [[NSArray alloc] initWithObjects:navigationController01, navigationController02, navigationController03, nil];
        [self setViewControllers:allViewControllers];
                
    }
    return self;
}

@end
