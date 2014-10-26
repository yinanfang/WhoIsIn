//
//  GCMainContainerViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCMainContainerViewController.h"
#import "GCMainTabController.h"

@implementation GCMainContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DDLogInfo(@"====================  Entered main container controller  ====================");
    
    // Initialize Variables
    // Background color is default to clear color and frame to fill the screen
    
    
    // Main init
    self.mainTabController = [[GCMainTabController alloc] initWithParentController:self];
    [self addChildViewController:self.mainTabController];
    [self.view addSubview:self.mainTabController.view];
    [self.mainTabController didMoveToParentViewController:self];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}




@end
