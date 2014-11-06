//
//  GCRegisterScrollView.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRegisterViewController.h"
#import "GCRegisterScrollView.h"

@implementation GCRegisterScrollView

- (instancetype)initWithParentController:(GCRegisterViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        [self.parentController.view addSubview:self];
        
        // Login Field
        self.view_Register = [[UIView alloc] init];
        self.view_Register.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.view_Register];
        
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
