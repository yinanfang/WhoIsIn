//
//  GCSignInViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSignInViewController.h"
#import "GCRegisterViewController.h"

@implementation GCSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
//    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@""];
    
    // Add Sign In View
    self.signInView = [[GCSignInView alloc] initWithParentController:self];
    [self.signInView setNeedsUpdateConstraints];
    [self.signInView updateConstraintsIfNeeded];
    
    // Sign In View Text Delegate
    self.signInView.entry_Username.delegate = self;
    self.signInView.entry_Password.delegate = self;

    // Register Button
    [[self.signInView.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Register button tapped");
        GCRegisterViewController *registerViewController = [[GCRegisterViewController alloc] init];
        [self.navigationController pushViewController:registerViewController animated:YES];
    }];
    
    // Short cut
    [[self.signInView.btn_HelpMe rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Help Me button tapped");
        [GCAppViewModel enterMainContainerViewController:self];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DDLogVerbose(@"textFieldShouldBeginEditing");
    
    [self moveUpContent];
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
        [self showLoginProgress];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, AnimationDuration_Short*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self login];
        });
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)login
{
    [GCAppViewModel loginWithCredential:@{
                                          @"email": @"sckclark@gmail.com",
                                          @"password": @"68e419b67218d5cd2c84dd95a57b9e90",
                                          } completion:^(BOOL succeeded) {
                                              
                                          }];
}

// Hide keyboard when touching the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.signInView.entry_Username isFirstResponder] && [touch view] != self.signInView.entry_Username) {
        [self.signInView.entry_Username resignFirstResponder];
        [self moveDownContent];
    }
    if ([self.signInView.entry_Password isFirstResponder] && [touch view] != self.signInView.entry_Password) {
        [self.signInView.entry_Password resignFirstResponder];
        [self moveDownContent];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Animations
- (void)moveUpContent
{
    [self.signInView layoutIfNeeded];
    [UIView animateWithDuration:AnimationDuration_Short delay:AnimationDelay_Short options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // App Logo
        [self.signInView.appName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signInView.mas_top).with.offset(ScreenHeight/8);
        }];
        // Login Field
        [self.signInView.view_LogIn mas_updateConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.signInView.mas_top).with.offset(ScreenHeight/3);
        }];
        [self.signInView layoutIfNeeded];
    }completion:nil];
}

- (void)moveDownContent
{
    [self.signInView layoutIfNeeded];
    [UIView animateWithDuration:AnimationDuration_Short delay:AnimationDelay_Short options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // App Logo
        [self.signInView.appName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signInView.mas_top).with.offset(ScreenHeight/5);
        }];
        // Login Field
        [self.signInView.view_LogIn mas_updateConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.signInView.mas_top).with.offset(ScreenHeight/2);
        }];
        [self.signInView layoutIfNeeded];
    }completion:nil];
}

- (void)showLoginProgress
{
    [self.signInView layoutIfNeeded];
    [UIView animateWithDuration:AnimationDuration_Short delay:AnimationDelay_Short options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // App Logo
        [self.signInView.appName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signInView.mas_top).with.offset(ScreenHeight/2-80);
        }];
        self.signInView.appName.shimmering = YES;
        // Login Field
        [self.signInView.view_LogIn mas_updateConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.signInView.mas_top).with.offset(ScreenHeight/2);
        }];
        [self.signInView layoutIfNeeded];
    }completion:nil];
    // Fade
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.toValue = @(0.0);
    anim.duration = AnimationDuration_Short;
    [self.signInView.view_LogIn pop_addAnimation:anim forKey:@"fade"];
    [self.signInView.view_Others pop_addAnimation:anim forKey:@"fade"];

}

@end
