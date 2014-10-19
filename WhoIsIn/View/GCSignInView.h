//
//  GCSignInView.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSignInViewController;

@interface GCSignInView : UIView <UITextFieldDelegate>

// Self
@property GCSignInViewController *parentController;
@property BOOL didSetupConstraints;

#pragma mark -  Content
// App logo
@property FBShimmeringView *appName;

// Login Field
@property UIView *view_LogIn;
// Log In
@property UITextField *entry_Username, *entry_Password;
@property UIView *separator_Username;

// Other field
@property UIView *view_Others;
// Register
@property UIButton *btn_Register;
// Help me
@property UIButton *btn_HelpMe;

#pragma mark -  Method
- (id)initWithParentController:(GCSignInViewController *)controller;

// Factory Method
+ (UITextField *)SignInViewTextFieldWithPlaceHolder:(NSString *)placeHolder;

@end

