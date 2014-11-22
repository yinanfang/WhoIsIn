//
//  GCSortControlViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSortControlViewController.h"

@implementation GCSortControlViewController

- (instancetype)initWithParentController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        // Background color is default to clear color and frame to fill the screen
        self.view.backgroundColor = [UIColor redColor];
        self.parentController = controller;
//        [self updateViewConstraints];


        
    }
    return self;
}

- (void)updateViewConstraints
{
    DDLogVerbose(@"GCSortControlViewController updateViewConstraints");
    CGFloat topOffset = [GCAppAPI getSizeOfStatusbarAndNavigationBar:self.parentController].height;
    CGFloat sortBarHeight = [GCAppAPI getSizeOfNavigationBar:self.parentController].height;
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.parentController.view.mas_top).with.offset(topOffset);
        make.left.equalTo(self.parentController.view.mas_left);
        make.right.equalTo(self.parentController.view.mas_right);
        make.height.mas_equalTo(sortBarHeight);
    }];    
    [super updateViewConstraints];
}

@end
