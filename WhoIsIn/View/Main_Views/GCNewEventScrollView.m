//
//  GCNewEventScrollView.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNewEventViewController.h"
#import "GCNewEventScrollView.h"

@implementation GCNewEventScrollView

- (instancetype)initWithParentController:(GCNewEventViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
//        self.backgroundColor = [GCAppAPI getColorWithRGBAinHex:BackgroundWhiteShade];
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        // Login Field
        self.view_Event = [[UIView alloc] init];
        [self.view_Event setTintColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];    // Float label when editing
        [self addSubview:self.view_Event];
        // Title
        self.entry_Title = [self addLabeledTextFieldWithPlaceHolder:@"Event Name"];
        self.entry_Title.tag = 1;
        self.separator_Title = [self addSeparator];
        // Description
        self.entry_Description = [self addLabeledTextViewWithPlaceHolder:@"Details"];
        self.entry_Description.tag = 2;
        self.separator_Description = [self addSeparator];
        
        // Location
        self.entry_Location = [self addLabeledTextFieldWithPlaceHolder:@"Location"];
        self.entry_Location.tag = 3;
        self.separator_Location = [self addSeparator];
        
        // Start Time
        self.entry_TimeStart = [self addLabeledTextFieldWithPlaceHolder:@"Start"];
        self.picker_TimeStart = [self addDataPickerToEntry:self.entry_TimeStart];
        self.entry_TimeStart.tag = 4;
        self.separator_TimeStart = [self addSeparator];
        // End Time
        self.entry_TimeEnd = [self addLabeledTextFieldWithPlaceHolder:@"End"];
        self.picker_TimeEnd = [self addDataPickerToEntry:self.entry_TimeEnd];
        self.entry_TimeEnd.tag = 5;
        self.separator_TimeEnd = [self addSeparator];
        
        // Phone
        self.entry_PhoneNumber = [self addLabeledTextFieldWithPlaceHolder:@"Phone Number of Host"];
        self.entry_PhoneNumber.tag = 6;
        self.separator_PhoneNumber = [self addSeparator];
        // Email
        self.entry_Email = [self addLabeledTextFieldWithPlaceHolder:@"Email of Host"];
        self.entry_Email.returnKeyType = UIReturnKeyDone;
        self.entry_Email.tag = 7;
        self.separator_Email = [self addSeparator];
        
        
        // test

//        JVFloatLabeledTextView *descriptionField = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
//        descriptionField.placeholder = NSLocalizedString(@"Description", @"");
//        descriptionField.placeholderTextColor = [UIColor darkGrayColor];
//        descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//        descriptionField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
////        descriptionField.floatingLabelTextColor = floatingLabelColor;
//        [self.view_Event addSubview:descriptionField];
        
        
        
//        // Gender
//        self.entry_Gender = [self addLabeledTextFieldWithPlaceHolder:@"Gender"];
//        self.entry_Gender.tag = 6;
//        // Change input view
//        self.picker_Gender = [[UIPickerView alloc] initWithFrame:CGRectZero];
//        self.picker_Gender.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
//        self.picker_Gender.showsSelectionIndicator = YES;
//        self.entry_Gender.inputView = self.picker_Gender;
//        self.separator_Gender = [self addSeparator];
        // Error Message
        self.label_ErrorMessage = [self addLabelTitleWithString:@""];
        
        // Register Button
        self.btn_Done = [self addFUIButtonWithTitle:@"Done"];
    }
    return self;
}

const static CGFloat kEntryFieldHeight = 40.0f;
- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        
        // Login Field
        [self.view_Event mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
        }];
        // Title
        [self.entry_Title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_Event.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.view_Event.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.view_Event.mas_right).with.offset(mas_Padding_Page_Small.right);
            make.height.mas_equalTo(kEntryFieldHeight);
        }];
        [self pinView:self.separator_Title toUpperview:self.entry_Title];
        // Desctiption
        [self.entry_Description mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separator_Title.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.view_Event.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.view_Event.mas_right).with.offset(mas_Padding_Page_Small.right);
            make.height.mas_equalTo(150);
//            self.entry_Description.contentOffset = CGPointZero;
        }];
        [self pinView:self.separator_Description toUpperview:self.entry_Description];
        
        // Location
        [self pinView:self.entry_Location toUpperview:self.separator_Description];
        [self pinView:self.separator_Location toUpperview:self.entry_Location];
        
        // Time Start & End
        [self pinView:self.entry_TimeStart toUpperview:self.separator_Location];
        [self pinView:self.separator_TimeStart toUpperview:self.entry_TimeStart];
        [self pinView:self.entry_TimeEnd toUpperview:self.separator_TimeStart];
        [self pinView:self.separator_TimeEnd toUpperview:self.entry_TimeEnd];
        
        // Phone Number
        [self pinView:self.entry_PhoneNumber toUpperview:self.separator_TimeEnd];
        [self pinView:self.separator_PhoneNumber toUpperview:self.entry_PhoneNumber];
        // Email
        [self pinView:self.entry_Email toUpperview:self.separator_PhoneNumber];
        [self pinView:self.separator_Email toUpperview:self.entry_Email];
        // Error Message
        [self.label_ErrorMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separator_Email.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.view_Event.mas_left);
            make.right.equalTo(self.view_Event.mas_right);
            make.bottom.equalTo(self.view_Event.mas_bottom);
        }];
        
        // Register Button
        [self.btn_Done mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view_Event.mas_bottom).with.offset(mas_Padding_Page_Large.top);
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
        make.left.equalTo(self.view_Event.mas_left).with.offset(mas_Padding_Page_Small.left);
        make.right.equalTo(self.view_Event.mas_right).with.offset(mas_Padding_Page_Small.right);
        if ([view isMemberOfClass:[JVFloatLabeledTextField class]]) {
            make.height.mas_equalTo(kEntryFieldHeight);
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
// Text size configuration
const static CGFloat kJVFieldFontSize = 20.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 12.0f;
- (JVFloatLabeledTextField *)addLabeledTextFieldWithPlaceHolder:(NSString *)string
{
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
    [self.view_Event addSubview:textfield];
    return textfield;
}

- (JVFloatLabeledTextView *)addLabeledTextViewWithPlaceHolder:(NSString *)string
{
//    JVFloatLabeledTextView *textView = [[JVFloatLabeledTextView alloc] init];
    JVFloatLabeledTextView *textView = [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    textView.placeholder = NSLocalizedString(string, @"");
    textView.placeholderTextColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    textView.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    textView.floatingLabelTextColor = [UIColor lightGrayColor];        // Label color when not editing
    textView.clearsOnInsertion = NO;
    textView.returnKeyType = UIReturnKeyDefault;
    textView.placeholderYPadding = 0;
    textView.contentOffset = CGPointZero;
    [self.view_Event addSubview:textView];
    return textView;
}

- (UIView *)addSeparator
{
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view_Event addSubview:separator];
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
    [label setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
    [self.view_Event addSubview:label];
    return label;
}

- (UIDatePicker *)addDataPickerToEntry:(JVFloatLabeledTextField *)textField
{
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    picker.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
    textField.inputView = picker;
    return picker;
}
@end
