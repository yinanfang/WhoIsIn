//
//  GCRegisterViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRegisterViewController.h"

@implementation GCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Register"];
    
    // Add Register View
    self.registerView = [[GCRegisterScrollView alloc] initWithParentController:self];
    [self.registerView setNeedsUpdateConstraints];
    [self.registerView updateConstraintsIfNeeded];
//
//    // Sign In View Text Delegate
//    self.signInView.entry_Username.delegate = self;
//    self.signInView.entry_Password.delegate = self;
//    
//    // Register Button
//    [[self.signInView.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"Register button tapped");
//        GCRegisterViewController *registerViewController = [[GCRegisterViewController alloc] init];
//        [self.navigationController pushViewController:registerViewController animated:YES];
//    }];
//    
//    // Short cut
//    [[self.signInView.btn_HelpMe rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"Help Me button tapped");
//        [GCAppViewModel enterMainContainerViewController:self];
//    }];
}




- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Register";
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{

}


@end
