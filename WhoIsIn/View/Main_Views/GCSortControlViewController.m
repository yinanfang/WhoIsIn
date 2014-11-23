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

        self.sortControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Nearby", @"Upcoming", @"All", nil]];
        self.sortControl.selectedSegmentIndex = 0;
//        [self.sortControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        self.sortControl.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        [self.view addSubview:self.sortControl];
        
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
    
    [self.sortControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(mas_Padding_Page_Default.top);
        make.left.equalTo(self.view.mas_left).with.offset(mas_Padding_Page_Default.left);
        make.right.equalTo(self.view.mas_right).with.offset(mas_Padding_Page_Default.right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(mas_Padding_Page_Default.bottom);
    }];
    [super updateViewConstraints];
}


@end
