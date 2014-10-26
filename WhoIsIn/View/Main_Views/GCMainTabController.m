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

- (id)initWithParentController:(GCMainContainerViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        // Background color is default to clear color and frame to fill the screen
        self.parentController = controller;
        
        // Empty Frame Initialization
        self.activityController = [GCActivityController new];
        self.activityController.tabBarItem.title = @"Activity";
        
        self.userInfoController = [GCUserInfoController new];
        self.userInfoController.tabBarItem.title = @"My Activity";
        
        self.accountController = [GCAccountController new];
        self.accountController.tabBarItem.title = @"Account";
        
        NSArray *allViewControllers = [[NSArray alloc] initWithObjects:self.activityController, self.userInfoController, self.accountController, nil];
        [self setViewControllers:allViewControllers];
        
    }
    return self;
}

@end
