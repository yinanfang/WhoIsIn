//
//  GCEventDetailViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventDetailViewController.h"

@implementation GCEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Activity Detail"];
    
    // Add Activity Detail Scroll View
    self.detailScrollView = [[GCEventDetailScrollView alloc] initWithParentController:self];
    [self.detailScrollView setNeedsUpdateConstraints];
    [self.detailScrollView updateConstraintsIfNeeded];
    
    [[self.detailScrollView.btn_join rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Join button tapped");

    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"GCActivity Detail View Controller touchesBegan:withEvent:");
    [super touchesBegan:touches withEvent:event];
}


@end
