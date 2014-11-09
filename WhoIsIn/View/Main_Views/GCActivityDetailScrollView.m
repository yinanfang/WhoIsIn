//
//  GCActivityDetailScrollView.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityDetailScrollView.h"
#import "GCActivityDetailViewController.h"

@implementation GCActivityDetailScrollView

- (instancetype)initWithParentController:(GCActivityDetailViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        // Corresponding GCActivity
        GCActivity *activity = (GCActivity *)[GCAppViewModel sharedInstance].sortedActivities[self.parentController.activityNumber];
        
        // Title in Bold
        self.label_title = [self LabelTitleWithString:activity.activityTitle bold:NO fontSize:kCellFontSizeLarge];
        
        // Host
        self.label_host = [self LabelTitleWithString:[NSString stringWithFormat:@"Hosted by %@ %@", activity.nameFirst, activity.nameLast] bold:NO fontSize:kCellFontSizeSmall];
        // Start Time
        static NSDateFormatter *kDateFormatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            kDateFormatter = [[NSDateFormatter alloc] init];
            kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            kDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";  // you configure this based on the strings that your webservice uses!!
        });
        self.label_timeStart = [self LabelTitleWithString:[kDateFormatter stringFromDate:activity.timeStart] bold:NO fontSize:kCellFontSizeSmall];
        // Location
        self.label_location = [self LabelTitleWithString:activity.locationString bold:NO fontSize:kCellFontSizeSmall];
        self.label_location.textColor = [UIColor lightGrayColor];
        // Distance in text
        self.label_distanceText = [self LabelTitleWithString:activity.distanceString bold:NO fontSize:kCellFontSizeSmall];
        self.label_distanceText.textColor = [UIColor lightGrayColor];
        
        // Participants and Watchers
//        self.label_participantAndWatcher = [self LabelTitleWithString:@"Participant and Watcher" bold:NO fontSize:kCellFontSizeSmall];
        
        //        self.label_description = [GCActivityTableViewCell LabelTitleWithString:@"Activity description is even longer. May there or 10 rows. It will never ends until the end of the world. WTF???? I don't want this to continue any more!" bold:NO];

        
    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        
        // View Items
        [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.mas_right).offset(mas_Padding_Page_Default.right);
        }];
        
        [self pinView:self.label_host toUpperview:self.label_title];
        [self pinView:self.label_timeStart toUpperview:self.label_host];
        [self pinView:self.label_location toUpperview:self.label_timeStart];
        [self pinView:self.label_distanceText toUpperview:self.label_location];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)pinView:(UIView *)view toUpperview:(UIView *)upperview
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Default.top);
        make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Default.left);
        make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Default.right);
        //        if ([view isMemberOfClass:[JVFloatLabeledTextField class]]) {
        //            make.height.mas_equalTo(40);
        //        } else {
        //            make.height.mas_equalTo(1);
        //        }
    }];
}

static const CGFloat kCellFontSizeLarge = 18.0f;
static const CGFloat kCellFontSizeSmall = 13.0f;
- (UILabel *)LabelTitleWithString:(NSString *)title bold:(BOOL)isBold fontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    if (isBold) {
        [label setFont:[UIFont fontWithName:FontTheme01_Bold size:size]];
    } else {
        [label setFont:[UIFont fontWithName:FontTheme01 size:size]];
    }
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
    [self addSubview:label];
    return label;
}



@end
