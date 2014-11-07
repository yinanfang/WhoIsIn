//
//  GCRegisterScrollView.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRegisterViewController.h"
#import "GCRegisterScrollView.h"

@implementation GCRegisterScrollView

const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

- (instancetype)initWithParentController:(GCRegisterViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        [self.parentController.view addSubview:self];
        
        // Login Field
        self.view_Register = [[UIView alloc] init];
        self.view_Register.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.view_Register];
        
        UIColor *floatingLabelColor = [UIColor lightGrayColor];
        
        self.entry_Email = [[JVFloatLabeledTextField alloc] init];
        self.entry_Email.attributedPlaceholder = [[NSAttributedString alloc]
                                                  initWithString:NSLocalizedString(@"Title", @"")
                                                  attributes:@{
                                                               NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                               }];
        self.entry_Email.font = [UIFont systemFontOfSize:kJVFieldFontSize];
        self.entry_Email.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
        self.entry_Email.floatingLabelTextColor = floatingLabelColor;
        self.entry_Email.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view_Register addSubview:self.entry_Email];

        
        
//        @property JVFloatLabeledTextField *entry_Email;
//        @property UIView *separator_Email;
//        @property JVFloatLabeledTextField *entry_Password;
//        @property UIView *separator_Password;
//        @property JVFloatLabeledTextField *entry_Firstname;
//        @property UIView *separator_FIrstName;
//        @property JVFloatLabeledTextField *entry_LastName;
//        @property UIView *separator_LastName;
//        @property JVFloatLabeledTextField *entry_PhoneNumber;
//        @property UIView *separator_PhoneNumber;
//        @property JVFloatLabeledTextField *entry_Gender;
//        @property UIView *separator_Gender;
        
        
//        // User name
//        self.entry_Username = [GCRegisterScrollView SignInViewTextFieldWithPlaceHolder:@"Email Login"];
//        self.entry_Username.returnKeyType = UIReturnKeyNext;
//        self.entry_Username.tag = 1;
////        self.entry_Username.inputView
//        [self.view_Register addSubview:self.entry_Username];
        
        
        
//        email
//        Email address will be used as user name for the login.
        
//        password
//        The password should be in the form of hashed MD5 value.
        
//        firstName
//        The first name of the user.
        
//        LastName
//        The last name of the user.
        
//        phoneNumber (Optional)
//        The phone number of the user.
        
//        gender		
//        The gender of the user, “M” is male,“F” is female.

        
    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        
        // Login Field
        [self.view_Register mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);

//            make.top.equalTo(self.mas_top).with.offset(ScreenHeight/2);
//            make.size.mas_equalTo(CGSizeMake(ScreenWidth-2*mas_Padding_Page_Large.left, ScreenWidth/3));
        }];
        // User Name
        [self.entry_Email mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view_Register.mas_centerX);
            make.top.equalTo(self.view_Register.mas_top);
            make.left.equalTo(self.view_Register.mas_left);
            make.right.equalTo(self.view_Register.mas_right);
            make.height.mas_equalTo(FontSize_LogInTextField+5);
        }];

        self.didSetupConstraints = YES;
    }    
    [super updateConstraints];
}

#pragma mark - Factory Methods
+ (UITextField *)SignInViewTextFieldWithPlaceHolder:(NSString *)placeHolderString
{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.font = [UIFont fontWithName:Font_Title size:FontSize_LogInTextField];
    textField.textColor = [UIColor whiteColor];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolderString attributes:@{NSForegroundColorAttributeName:[GCAppAPI getColorWithRGBAinHex:WhiteFading], NSFontAttributeName:[UIFont fontWithName:Font_Title size:FontSize_LogInTextField]}];
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.enablesReturnKeyAutomatically = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}

+ (UIButton *)ButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[GCAppAPI getColorWithRGBAinHex:WhiteFading] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:Font_Title size:FontSize_H1];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    return button;
}

@end
