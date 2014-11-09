//
//  GCActivityTableViewCell.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/2/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityTableViewCell.h"

@implementation GCActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        DDLogWarn(@"initWithStyle");
        
        // Title in Bold
        self.label_title = [self LabelTitleWithString:@"Activity Title is a very long thing. It usually take up 2 rows" bold:NO fontSize:kCellFontSizeLarge];
        
        // Start Time
        self.label_timeStart = [self LabelTitleWithString:@"Time to start" bold:NO fontSize:kCellFontSizeSmall];
        // Location
        self.label_location = [self LabelTitleWithString:@"Activity Location" bold:NO fontSize:kCellFontSizeSmall];
        self.label_location.textColor = [UIColor lightGrayColor];
        // Distance in text
        self.label_distanceText = [self LabelTitleWithString:@"Distance text" bold:NO fontSize:kCellFontSizeSmall];
        self.label_distanceText.textColor = [UIColor lightGrayColor];
        
        // Participants and Watchers
        self.label_participantAndWatcher = [self LabelTitleWithString:@"Participant and Watcher" bold:NO fontSize:kCellFontSizeSmall];
        
        
//        self.contentView.layer.cornerRadius = 10.0f;
//        self.contentView.layer.masksToBounds = YES;
//        self.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
    }
    return self;
}

- (void)updateConstraints
{
    NSLog(@"updateConstraints table cell.");
    if (!self.didSetupConstraints) {
        // Expand the content view temporariry
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 1000.0f, 1000.0f);
        
        [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
        }];
        
        [self pinView:self.label_timeStart toUpperview:self.label_title];
        [self pinView:self.label_location toUpperview:self.label_timeStart];
        [self pinView:self.label_distanceText toUpperview:self.label_location];

        [self.label_participantAndWatcher mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_distanceText.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Small.bottom);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)pinView:(UIView *)view toUpperview:(UIView *)upperview
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Small.top);
        make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
        make.right.equalTo(self.contentView.mas_right).with.offset(mas_Padding_Page_Small.right);
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
    [self.contentView addSubview:label];
    return label;
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews table cell.");
    [super layoutSubviews];
    // Make sure the contentView does a layout pass, which set the frames in order to calculate the preferredMaxLayoutWidth
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Solve multi-line UILabel issue. Calculate actual height depends on the label width
    self.label_title.preferredMaxLayoutWidth = CGRectGetWidth(self.label_title.frame);
    self.label_participantAndWatcher.preferredMaxLayoutWidth = CGRectGetWidth(self.label_participantAndWatcher.frame);
    self.label_location.preferredMaxLayoutWidth = CGRectGetWidth(self.label_location.frame);
}

@end
