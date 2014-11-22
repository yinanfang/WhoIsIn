//
//  GCEventTableViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventTableViewController.h"

@implementation GCEventTableViewController

- (instancetype)initWithParentController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        self.parentController = controller;
        self.view.backgroundColor = [UIColor lightGrayColor];

        
    }
    return self;
}

- (void)updateViewConstraints
{
    DDLogVerbose(@"GCEventTableViewController updateViewConstraints");
    CGFloat topOffset = [GCAppAPI getSizeOfStatusbarAndNavigationBar:self.parentController].height;
    CGFloat sortBarHeight = [GCAppAPI getSizeOfNavigationBar:self.parentController].height;
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.parentController.view.mas_top).with.offset(topOffset+sortBarHeight);
        make.left.equalTo(self.parentController.view.mas_left);
        make.right.equalTo(self.parentController.view.mas_right);
        make.bottom.equalTo(self.parentController.view.mas_bottom);
    }];
    [super updateViewConstraints];
}

@end
