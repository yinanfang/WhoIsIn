//
//  GCNewEventViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNewEventViewController.h"

@implementation GCNewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"New Event"];
    
    // Add Register View
    self.eventScrollView = [[GCNewEventScrollView alloc] initWithParentController:self];
    [self.eventScrollView setNeedsUpdateConstraints];
    [self.eventScrollView updateConstraintsIfNeeded];
    // Assign UITextField Delegates
//    self.registerView.entry_Email.delegate = self;
//    self.registerView.entry_Password.delegate = self;
//    self.registerView.entry_Firstname.delegate = self;
//    self.registerView.entry_LastName.delegate = self;
//    self.registerView.entry_PhoneNumber.delegate = self;
//    self.registerView.entry_Gender.delegate = self;
    // Assign UIPickerView Delegates
//    self.registerView.picker_Gender.delegate = self;
//    self.registerView.picker_Gender.dataSource = self;
    
    // Register Button
//    [[self.registerView.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        DDLogVerbose(@"Register button tapped");
//        [self restoreContentOffset];
//        [[GCAppAPI getFirstResponderFromView:self.registerView.view_Register] resignFirstResponder];
//        //        BOOL isValidInput = YES;
//        BOOL isValidInput = [self isValidInput];
//        if (isValidInput) {
//            DDLogVerbose(@"Input format correct! Start Register process...");
//            // Clear error message label
//            self.registerView.label_ErrorMessage.text = @"";
//            [self registerUser];
//        }
//        
//    }];
    
}

// Hide keyboard when touching the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"GCRegisterViewController touchesBegan:withEvent:");
    UITouch *touch = [[event allTouches] anyObject];
    UIView *responder = [GCAppAPI getFirstResponderFromView:self.eventScrollView.view_Event];
    if (responder && [touch view] != responder) {
        [responder resignFirstResponder];
    }
//    [self restoreContentOffset];
    [super touchesBegan:touches withEvent:event];
}

@end
