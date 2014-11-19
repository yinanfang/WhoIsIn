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
    // Assign UITextField Delegates
    self.registerView.entry_Email.delegate = self;
    self.registerView.entry_Password.delegate = self;
    self.registerView.entry_Firstname.delegate = self;
    self.registerView.entry_LastName.delegate = self;
    self.registerView.entry_PhoneNumber.delegate = self;
    self.registerView.entry_Gender.delegate = self;
    // Assign UIPickerView Delegates
    self.registerView.picker_Gender.delegate = self;
    self.registerView.picker_Gender.dataSource = self;
    
    // Register Button
    [[self.registerView.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Register button tapped");
//        GCRegisterViewController *registerViewController = [[GCRegisterViewController alloc] init];
//        [self.navigationController pushViewController:registerViewController animated:YES];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    // Configure Navigation Bar
    self.title = @"Register";
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;

    // Super
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Super
    [super viewDidAppear:animated];
}

// Hide keyboard when touching the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"GCRegisterViewController touchesBegan:withEvent:");
    UITouch *touch = [[event allTouches] anyObject];
    UIView *responder = [GCAppAPI getFirstResponderFromView:self.registerView.view_Register];
    if (responder && [touch view] != responder) {
        [responder resignFirstResponder];
    }
    [self restoreContentOffset];
    [super touchesBegan:touches withEvent:event];
}

- (void)restoreContentOffset
{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:AnimationDuration_Short delay:AnimationDelay_None options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.registerView.contentOffset = CGPointMake(0, -[GCAppAPI getSizeOfStatusbarAndNavigationBar:self].height);
        [self.view layoutIfNeeded];
    }completion:nil];
    self.registerView.contentOffset = CGPointMake(0, -[GCAppAPI getSizeOfStatusbarAndNavigationBar:self].height);
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DDLogVerbose(@"textFieldShouldBeginEditing");
    [self centerTextfield:textField];
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

- (void)centerTextfield:(UITextField *)textField
{
    DDLogVerbose(@"centerTextfield");
    CGFloat statusBarAndNavBarHeight = [GCAppAPI getSizeOfStatusbarAndNavigationBar:self].height;
    CGPoint textFieldCenterInScrollView = [self.registerView.view_Register convertPoint:textField.center toView:self.registerView];
    CGFloat difference = (textFieldCenterInScrollView.y+(-self.registerView.contentOffset.y)) - (statusBarAndNavBarHeight+(ScreenHeight-KeyboardHeightPortrait-statusBarAndNavBarHeight)/2);
    DDLogVerbose(@"difference: %f", difference);
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:AnimationDuration_Short delay:AnimationDelay_None options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.registerView.contentOffset = CGPointMake(self.registerView.contentOffset.x, self.registerView.contentOffset.y+difference);
        [self.view layoutIfNeeded];
    }completion:nil];
}

#pragma mark - UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"M";
    } else {
        return @"F";
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.registerView.entry_Gender.text = (row == 0) ? @"M" : @"F";
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

@end
