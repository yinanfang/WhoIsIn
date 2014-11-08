//
//  GCActivityDetailViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityDetailViewController.h"

@implementation GCActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Activity Detail"];
    
    // Add Activity Detail Scroll View
    self.detailScrollView = [[GCActivityDetailScrollView alloc] initWithParentController:self];
    [self.detailScrollView setNeedsUpdateConstraints];
    [self.detailScrollView updateConstraintsIfNeeded];
    // Assign Delegates
//    self.registerView.entry_Email.delegate = self;
//    self.registerView.entry_Password.delegate = self;
//    self.registerView.entry_Firstname.delegate = self;
//    self.registerView.entry_LastName.delegate = self;
//    self.registerView.entry_PhoneNumber.delegate = self;
//    self.registerView.entry_Gender.delegate = self;
    
    // Register Button
//    [[self.registerView.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        NSLog(@"Register button tapped");
//        //        GCRegisterViewController *registerViewController = [[GCRegisterViewController alloc] init];
//        //        [self.navigationController pushViewController:registerViewController animated:YES];
//    }];
    
}

@end
