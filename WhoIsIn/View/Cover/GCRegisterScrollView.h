//
//  GCRegisterScrollView.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCRegisterViewController;

@interface GCRegisterScrollView : UIScrollView

// Self
@property GCRegisterViewController *parentController;
@property BOOL didSetupConstraints;

#pragma mark -  Content
// Login Field
@property UIView *view_Register;
// Register
@property JVFloatLabeledTextField *entry_Email;
@property UIView *separator_Email;
@property JVFloatLabeledTextField *entry_Password;
@property UIView *separator_Password;
@property JVFloatLabeledTextField *entry_Firstname;
@property UIView *separator_FirstName;
@property JVFloatLabeledTextField *entry_LastName;
@property UIView *separator_LastName;
@property JVFloatLabeledTextField *entry_PhoneNumber;
@property UIView *separator_PhoneNumber;
@property JVFloatLabeledTextField *entry_Gender;
@property UIPickerView *picker_Gender;
@property UIView *separator_Gender;
@property UILabel *label_ErrorMessage;

// Register Button
@property FUIButton *btn_Register;

#pragma mark - View Method
- (instancetype)initWithParentController:(GCRegisterViewController *)controller;


@end
