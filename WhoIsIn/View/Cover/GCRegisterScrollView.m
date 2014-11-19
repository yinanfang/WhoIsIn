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

- (instancetype)initWithParentController:(GCRegisterViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        // Login Field
        self.view_Register = [[UIView alloc] init];
//        self.view_Register.backgroundColor = [UIColor redColor];
        [self.view_Register setTintColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];    // Float label when editing
        [self addSubview:self.view_Register];
        // Email
        self.entry_Email = [self addLabeledTextFieldWithPlaceHolder:@"Email Address"];
        self.entry_Email.tag = 1;
        self.separator_Email = [self addSeparator];
        // Password
        self.entry_Password = [self addLabeledTextFieldWithPlaceHolder:@"Password"];
        self.entry_Password.secureTextEntry = YES;
        self.entry_Password.tag = 2;
        self.separator_Password = [self addSeparator];
        // First Name
        self.entry_Firstname = [self addLabeledTextFieldWithPlaceHolder:@"First Name"];
        self.entry_Firstname.tag = 3;
        self.separator_FirstName = [self addSeparator];
        // Last Name
        self.entry_LastName = [self addLabeledTextFieldWithPlaceHolder:@"Last Name"];
        self.entry_LastName.tag = 4;
        self.separator_LastName = [self addSeparator];
        // Phone Number
        self.entry_PhoneNumber = [self addLabeledTextFieldWithPlaceHolder:@"Phone Number (Optional)"];
        self.entry_PhoneNumber.tag = 5;
        self.separator_PhoneNumber = [self addSeparator];
        // Gender
        self.entry_Gender = [self addLabeledTextFieldWithPlaceHolder:@"Gender"];
        self.entry_Gender.tag = 6;
        // Change input view
        self.picker_Gender = [[UIPickerView alloc] initWithFrame:CGRectZero];
        self.picker_Gender.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
        self.picker_Gender.showsSelectionIndicator = YES;
        self.entry_Gender.inputView = self.picker_Gender;
        self.separator_Gender = [self addSeparator];
        // Error Message
        self.label_ErrorMessage = [self addLabelTitleWithString:@""];
        
        // Register Button
        self.btn_Register = [self addFUIButtonWithTitle:@"Register"];
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
//            make.centerY.equalTo(self.mas_centerY);
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-2*mas_Padding_Page_Large.left, 370));
        }];
        // Email
        [self.entry_Email mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_Register.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.view_Register.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.view_Register.mas_right).with.offset(mas_Padding_Page_Small.right);
            make.height.mas_equalTo(40);
        }];
        [self pinView:self.separator_Email toUpperview:self.entry_Email];
        // Password
        [self pinView:self.entry_Password toUpperview:self.separator_Email];
        [self pinView:self.separator_Password toUpperview:self.entry_Password];
        // First Name
        [self pinView:self.entry_Firstname toUpperview:self.separator_Password];
        [self pinView:self.separator_FirstName toUpperview:self.entry_Firstname];
        // Last Name
        [self pinView:self.entry_LastName toUpperview:self.separator_FirstName];
        [self pinView:self.separator_LastName toUpperview:self.entry_LastName];
        // Phone Number
        [self pinView:self.entry_PhoneNumber toUpperview:self.separator_LastName];
        [self pinView:self.separator_PhoneNumber toUpperview:self.entry_PhoneNumber];
        // Gender
        [self pinView:self.entry_Gender toUpperview:self.separator_PhoneNumber];
        [self pinView:self.separator_Gender toUpperview:self.entry_Gender];
        // Error Message
        [self.label_ErrorMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separator_Gender.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.view_Register.mas_left);
            make.right.equalTo(self.view_Register.mas_right);
        }];
        
        // Register Button
        [self.btn_Register mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_Register.mas_bottom).with.offset(mas_Padding_Page_Large.top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(250, 50));
            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Large.bottom);
        }];
        
        self.didSetupConstraints = YES;
    }    
    [super updateConstraints];
}

- (void)pinView:(UIView *)view toUpperview:(UIView *)upperview
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Small.top);
        make.left.equalTo(self.view_Register.mas_left).with.offset(mas_Padding_Page_Small.left);
        make.right.equalTo(self.view_Register.mas_right).with.offset(mas_Padding_Page_Small.right);
        if ([view isMemberOfClass:[JVFloatLabeledTextField class]]) {
            make.height.mas_equalTo(40);
        } else {
            make.height.mas_equalTo(1);
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"GCRegisterScrollView touchesBegan:withEvent:");
    [super touchesBegan:touches withEvent:event];
    // Don't let UIScrollView eats up all the touch events. Pass it to nextResponder
    [self.nextResponder touchesBegan: touches withEvent:event];
}

#pragma mark - Factory Methods
- (JVFloatLabeledTextField *)addLabeledTextFieldWithPlaceHolder:(NSString *)string
{
    // Text size configuration
    const static CGFloat kJVFieldFontSize = 20.0f;
    const static CGFloat kJVFieldFloatingLabelFontSize = 12.0f;
    
    JVFloatLabeledTextField *textfield = [[JVFloatLabeledTextField alloc] init];
    textfield.attributedPlaceholder = [[NSAttributedString alloc]
                                              initWithString:NSLocalizedString(string, @"")
                                              attributes:@{
                                                           NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                           }];
    //        self.entry_Email.textColor = [UIColor whiteColor];
    textfield.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    textfield.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    textfield.floatingLabelTextColor = [UIColor lightGrayColor];        // Label color when not editing
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.returnKeyType = UIReturnKeyNext;
    [self.view_Register addSubview:textfield];
    return textfield;
}

- (UIView *)addSeparator
{
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view_Register addSubview:separator];
    return separator;
}


- (FUIButton *)addFUIButtonWithTitle:(NSString *)title
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    button.shadowColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
    button.shadowHeight = 1.0f;
    button.cornerRadius = 6.0f;
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_P1];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}

- (UILabel *)addLabelTitleWithString:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [label setFont:[UIFont fontWithName:FontTheme01 size:FontSize_P1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor redColor]];
    [label setText:title];
    [self.view_Register addSubview:label];
    return label;
}
@end
