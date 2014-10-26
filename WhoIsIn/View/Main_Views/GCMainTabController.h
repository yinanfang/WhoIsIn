//
//  GCMainTabController.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/25/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCMainContainerViewController;
#import "GCActivityController.h"
#import "GCUserInfoController.h"
#import "GCAccountController.h"

@interface GCMainTabController : UITabBarController

// Self
@property GCMainContainerViewController *parentController;
@property GCActivityController *activityController;
@property GCUserInfoController *userInfoController;
@property GCAccountController *accountController;


- (id)initWithParentController:(GCMainContainerViewController *)controller;

@end
