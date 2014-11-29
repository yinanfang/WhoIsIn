//
//  GCNewEventScrollView.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCNewEventViewController;

@interface GCNewEventScrollView : UIScrollView

// Self
@property GCNewEventViewController *parentController;
@property BOOL didSetupConstraints;

#pragma mark -  Content
// Login Field
@property UIView *view_Event;
// New Event parameter
@property JVFloatLabeledTextField *entry_Title;
@property UIView *separator_Title;
@property JVFloatLabeledTextView *entry_Description;
@property UIView *separator_Description;

@property JVFloatLabeledTextField *entry_Location;
@property UIView *separator_Location;

@property JVFloatLabeledTextField *entry_TimeStart;
@property UIDatePicker *picker_TimeStart;
@property UIView *separator_TimeStart;
@property JVFloatLabeledTextField *entry_TimeEnd;
@property UIDatePicker *picker_TimeEnd;
@property UIView *separator_TimeEnd;

@property JVFloatLabeledTextField *entry_PhoneNumber;
@property UIView *separator_PhoneNumber;
@property JVFloatLabeledTextField *entry_Email;
@property UIView *separator_Email;

@property UILabel *label_stickyToTop;
@property UISwitch *switch_stickyToTop;

@property UILabel *label_ErrorMessage;

// Register Button
@property FUIButton *btn_Done;

#pragma mark - View Method
- (instancetype)initWithParentController:(GCNewEventViewController *)controller;



@end
