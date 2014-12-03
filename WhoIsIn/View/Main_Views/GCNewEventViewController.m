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
    self.eventScrollView.entry_Title.delegate = self;
    self.eventScrollView.entry_Description.delegate = self;
    self.eventScrollView.entry_Location.delegate = self;
    self.eventScrollView.entry_TimeStart.delegate = self;
    self.eventScrollView.entry_TimeEnd.delegate = self;
    self.eventScrollView.entry_PhoneNumber.delegate = self;
    self.eventScrollView.entry_Email.delegate = self;
    // Assign UIPickerView Delegates
    [self.eventScrollView.picker_TimeStart addTarget:self action:@selector(datePickerDataChanged:) forControlEvents:UIControlEventValueChanged];
    [self.eventScrollView.picker_TimeEnd addTarget:self action:@selector(datePickerDataChanged:) forControlEvents:UIControlEventValueChanged];

    // Register Button
    [[self.eventScrollView.btn_Done rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DDLogVerbose(@"Done button tapped");
//        [self restoreContentOffset];
        [[GCAppAPI getFirstResponderFromView:self.eventScrollView.view_Event] resignFirstResponder];
//        BOOL isValidInput = YES;
        BOOL isValidInput = [self isValidInput];
        if (isValidInput) {
            DDLogVerbose(@"Input format correct! Start Register process...");
            // Clear error message label
            self.eventScrollView.label_ErrorMessage.text = @"";
            [self createEvent];
        }
        
    }];
    
}

- (BOOL)isValidInput
{
    if ([self.eventScrollView.entry_Title.text isEqual:@""]) {
        self.eventScrollView.label_ErrorMessage.text = @"Event name can't be empty";
        [GCAppAPI shakeViewArray:@[self.eventScrollView.entry_Title]];
        return NO;
    }
    if ([self.eventScrollView.entry_Location.text isEqual:@""]) {
        self.eventScrollView.label_ErrorMessage.text = @"Location can't be empty";
        [GCAppAPI shakeViewArray:@[self.eventScrollView.entry_Location]];
        return NO;
    }
    if ([self.eventScrollView.entry_TimeStart.text isEqual:@""]) {
        // Fill in time now
    }
    if ([self.eventScrollView.entry_TimeEnd.text isEqual:@""]) {
        // Fill in time 1 hour later
    }
    // Check email if filled in
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![self.eventScrollView.entry_Email.text isEqual:@""] && ![emailTest evaluateWithObject:self.eventScrollView.entry_Email.text]) {
        self.eventScrollView.label_ErrorMessage.text = @"Email format wrong";
        [GCAppAPI shakeViewArray:@[self.eventScrollView.entry_Email]];
        return NO;
    }
    return YES;
}

- (void)createEvent
{
    NSMutableDictionary *parameter = [@{
                                         @"method": @"createActivity",
                                         @"idUser": [NSString stringWithFormat:@"%@", [GCAppViewModel sharedInstance].appData.currentUser.userID],
                                         @"title": self.eventScrollView.entry_Title.text,
                                         @"description": self.eventScrollView.entry_Description.text,
                                         @"location": self.eventScrollView.entry_Location.text,
                                         @"startTime": [[GCAppAPI dateFormatter03] stringFromDate:self.eventScrollView.picker_TimeStart.date],
                                         @"duration": [NSString stringWithFormat:@"60"],    // Calculate duration
                                         @"firstName": self.eventScrollView.entry_PhoneNumber.text,
                                         @"lastName": self.eventScrollView.entry_Email.text,
                                         } mutableCopy];
//    [GCAppViewModel registerWithCredential:parameter completion:^(BOOL succeeded) {
//        if (succeeded) {
//            [GCAppViewModel createEventWithParameter:parameter completion:^(BOOL succeeded) {
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }];
//        } else {
//            DDLogVerbose(@"Create event failed. Need to enter again");
//            self.eventScrollView.label_ErrorMessage.text = @"Eamil exists. Register Failed.";
//        }
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
    [self restoreContentOffset];
    [super touchesBegan:touches withEvent:event];
}

- (void)restoreContentOffset
{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:kAnimationDuration_Short delay:kAnimationDelay_None options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.eventScrollView.contentOffset = CGPointMake(0, -[GCAppAPI getSizeOfStatusbarAndNavigationBar:self].height);
        [self.view layoutIfNeeded];
    }completion:nil];
    self.eventScrollView.contentOffset = CGPointMake(0, -[GCAppAPI getSizeOfStatusbarAndNavigationBar:self].height);
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DDLogVerbose(@"textFieldShouldBeginEditing");
    [self centerTextEntry:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DDLogVerbose(@"textFieldShouldReturn:");
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        [self restoreContentOffset];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

#pragma mark - UITextView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    DDLogVerbose(@"textViewShouldBeginEditing");
    [self centerTextEntry:textView];
    return YES;
}

- (void)centerTextEntry:(UIView *)textEntry
{
    DDLogVerbose(@"centerTextfield");
    CGFloat statusBarAndNavBarHeight = [GCAppAPI getSizeOfStatusbarAndNavigationBar:self].height;
    CGPoint textFieldCenterInScrollView = [self.eventScrollView.view_Event convertPoint:textEntry.center toView:self.eventScrollView];
    CGFloat difference = (textFieldCenterInScrollView.y+(-self.eventScrollView.contentOffset.y)) - (statusBarAndNavBarHeight+(ScreenHeight-KeyboardHeightPortrait-statusBarAndNavBarHeight)/2);
    //    DDLogVerbose(@"difference: %f", difference);
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:kAnimationDuration_Short delay:kAnimationDelay_None options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.eventScrollView.contentOffset = CGPointMake(self.eventScrollView.contentOffset.x, self.eventScrollView.contentOffset.y+difference);
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - UIDatePicker
- (void)datePickerDataChanged:(UIDatePicker *)picker
{
    if (picker == self.eventScrollView.picker_TimeStart) {
        self.eventScrollView.entry_TimeStart.text = [[GCAppAPI dateFormatter03] stringFromDate:picker.date];
    } else if (picker == self.eventScrollView.picker_TimeEnd) {
        self.eventScrollView.entry_TimeEnd.text = [[GCAppAPI dateFormatter03] stringFromDate:picker.date];
    }
}



@end
