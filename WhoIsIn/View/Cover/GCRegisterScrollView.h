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
// Log In
@property UITextField *entry_Username, *entry_Password;
@property UIView *separator_Username;

#pragma mark -  Method
- (instancetype)initWithParentController:(GCRegisterViewController *)controller;


@end
