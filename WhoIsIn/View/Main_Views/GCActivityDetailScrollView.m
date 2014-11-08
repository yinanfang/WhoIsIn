//
//  GCActivityDetailScrollView.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityDetailScrollView.h"
#import "GCActivityDetailViewController.h"

@implementation GCActivityDetailScrollView

- (instancetype)initWithParentController:(GCActivityDetailViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        
        
    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];

        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}




@end
