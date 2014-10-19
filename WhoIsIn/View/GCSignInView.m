//
//  GCSignInView.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSignInViewController.h"
#import "GCSignInView.h"

@implementation GCSignInView

- (id)initWithParentController:(GCSignInViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        [self.parentController.view addSubview:self];
        
        // Add book title with shimmer effect
        UILabel *appNameLabel = [[UILabel alloc] init];
        appNameLabel.textAlignment = NSTextAlignmentCenter;
        appNameLabel.font = [UIFont fontWithName:Font_Logo size:50];
        appNameLabel.textColor = [UIColor whiteColor];
        appNameLabel.backgroundColor = [UIColor clearColor];
        appNameLabel.textAlignment = NSTextAlignmentCenter;
        appNameLabel.text = @"Who's In";
        self.appName = [[FBShimmeringView alloc] initWithFrame:ScreenBounds];
        self.appName.shimmering = NO;
        self.appName.shimmeringBeginFadeDuration = 0.3;
        self.appName.shimmeringPauseDuration = 3;
        self.appName.shimmeringSpeed = 250;
        self.appName.shimmeringOpacity = 0.5;
        self.appName.contentView = appNameLabel;
        [self addSubview:self.appName];
        
        // Login Field
        self.view_LogIn = [UIView new];
//        self.view_LogIn.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.view_LogIn];
        // User name
        self.entry_Username = [GCSignInView SignInViewTextFieldWithPlaceHolder:@"Email Login"];
        self.entry_Username.delegate = self;
        [self.view_LogIn addSubview:self.entry_Username];
        // Separator
        self.separator_Username = [UIView new];
        self.separator_Username.backgroundColor = [GCAppAPI getColorWithRGBAinHex:WhiteFading];
        [self.view_LogIn addSubview:self.separator_Username];
        // Password
        self.entry_Password = [GCSignInView SignInViewTextFieldWithPlaceHolder:@"Password"];
        self.entry_Password.delegate = self;
        [self.view_LogIn addSubview:self.entry_Password];
        
        // Other Field
        self.view_Others = [UIView new];
        self.view_Others.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.view_Others];
        // Register
        self.btn_Register = [UIButton ButtonWithTitle:@"Register" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self.view_Others addSubview:self.btn_Register];
        // Help Me
        self.btn_HelpMe = [UIButton ButtonWithTitle:@"Help Me" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self.view_Others addSubview:self.btn_HelpMe];
    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        
        // App logo
        [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/5);
            make.size.mas_equalTo(CGSizeMake(250, 100));
        }];
        
        // Login Field
        [self.view_LogIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/2);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-2*mas_Padding_Page_Large.left, ScreenWidth/3));
        }];
        // User Name
        [self.entry_Username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view_LogIn.mas_centerX);
            make.top.equalTo(self.view_LogIn.mas_top);
            make.left.equalTo(self.view_LogIn.mas_left);
            make.right.equalTo(self.view_LogIn.mas_right);
            make.height.mas_equalTo(FontSize_LogInTextField+5);
        }];
        [self.separator_Username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view_LogIn.mas_centerX);
            make.top.equalTo(self.entry_Username.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.view_LogIn.mas_left);
            make.right.equalTo(self.view_LogIn.mas_right);
            make.height.mas_equalTo(1);
        }];
        [self.entry_Password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view_LogIn.mas_centerX);
            make.top.equalTo(self.separator_Username.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.view_LogIn.mas_left);
            make.right.equalTo(self.view_LogIn.mas_right);
            make.height.mas_equalTo(FontSize_LogInTextField+5);
        }];
        
        
        
        
        // Other Field
        [self.view_Others mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Large.bottom);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-2*mas_Padding_Page_Large.left, ScreenWidth/4));
        }];
        

        self.didSetupConstraints = YES;
    }
    
    
    [super updateConstraints];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DDLogVerbose(@"textFieldShouldBeginEditing");
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // App Logo
        [self.appName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/8);
        }];
        // Login Field
        [self.view_LogIn mas_updateConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/3);
        }];
        [self layoutIfNeeded];
    }completion:nil];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DDLogVerbose(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // App Logo
        [self.appName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/5);
        }];
        // Login Field
        [self.view_LogIn mas_updateConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/2);
        }];
        [self layoutIfNeeded];
    }completion:nil];
    return YES;
}

+ (UITextField *)SignInViewTextFieldWithPlaceHolder:(NSString *)placeHolderString
{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont systemFontOfSize:FontSize_LogInTextField];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderString attributes:@{NSForegroundColorAttributeName:[GCAppAPI getColorWithRGBAinHex:WhiteFading]}];
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}

@end

