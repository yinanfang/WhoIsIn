//
//  GCAccountController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAccountController.h"

@implementation GCAccountController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DDLogInfo(@"====================  Entered Account container controller  ====================");
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Caterpillars Count"];
    self.navigationItem.hidesBackButton = YES;
    UIButton *rightButton = [GCAppSetup configureRightButtonOfNavigationViewController:self];
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DDLogVerbose(@"hit Log out button. Clear User data and pop back");
        // Clear User Data
        [GCAppViewModel sharedInstance].appData.currentUser = [[GCUser alloc] init];
        [GCAppViewModel saveAppDataToNSUserDefaults];
        // Return to Login Page
        [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    // Initialize Variables
    self.view.backgroundColor = [UIColor redColor];
}


@end
