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
        
        self.label_timeStart = [GCActivityTableViewCell LabelTitleWithString:@"Time to start" bold:NO];
        [self.contentView addSubview:self.label_timeStart];
        
        self.label_distanceText = [GCActivityTableViewCell LabelTitleWithString:@"Distance text" bold:NO];
        self.label_distanceText.textColor = [UIColor redColor];
        [self.contentView addSubview:self.label_distanceText];
        
        self.label_title = [GCActivityTableViewCell LabelTitleWithString:@"Activity Title is a very long thing. It usually take up 2 rows" bold:NO];
        [self.contentView addSubview:self.label_title];
        
        self.label_description = [GCActivityTableViewCell LabelTitleWithString:@"Activity description is even longer. May there or 10 rows. It will never ends until the end of the world. WTF???? I don't want this to continue any more!" bold:NO];
        [self.contentView addSubview:self.label_description];
        
        self.label_location = [GCActivityTableViewCell LabelTitleWithString:@"Activity Location" bold:NO];
        [self.contentView addSubview:self.label_location];
        
        
        self.contentView.layer.cornerRadius = 10.0f;
        self.contentView.layer.masksToBounds = YES;
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
        
        [self.label_timeStart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
        }];
  
        [self.label_distanceText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
        }];
        
        [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_timeStart.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
        }];
        
        [self.label_description mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_title.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
        }];
        [self.label_location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_description.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Small.bottom);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

+ (UILabel *)LabelTitleWithString:(NSString *)title bold:(BOOL)isBold
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    [label setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_H1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
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
    self.label_description.preferredMaxLayoutWidth = CGRectGetWidth(self.label_description.frame);
    self.label_location.preferredMaxLayoutWidth = CGRectGetWidth(self.label_location.frame);
}

@end
