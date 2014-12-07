//
//  GCEventDetailScrollView.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventDetailViewController.h"
#import "GCEventDetailScrollView.h"

@implementation GCEventDetailScrollView

- (instancetype)initWithParentController:(GCEventDetailViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        // Content View
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        
        // Title in Bold
        self.label_title = [self addLabelTitleWithString:@"        " bold:NO fontSize:kDetailViewFontSizeLarge];
        
        // Host
        self.label_host = [self addLabelTitleWithString:@"      " bold:NO fontSize:kDetailViewFontSizeSmall];
        // Start Time
        self.label_timeStart = [self addLabelTitleWithString:@"      " bold:NO fontSize:kDetailViewFontSizeSmall];
        // Location
        self.label_location = [self addLabelTitleWithString:@"      " bold:NO fontSize:kDetailViewFontSizeSmall];
        self.label_location.textColor = [UIColor lightGrayColor];
        // Distance in text
        self.label_distanceText = [self addLabelTitleWithString:@"      " bold:NO fontSize:kDetailViewFontSizeSmall];
        self.label_distanceText.textColor = [UIColor lightGrayColor];
        
        // Buttons
        self.btn_join = [self addFUIButtonWithTitle:@"I'm In"];
        self.btn_maybe = [self addFUIButtonWithTitle:@"Maybe"];
        
        // Separator 01
        self.separator01 = [self addSeparator];
        
        // Description
        self.textviewDescription = [self addTextViewWithString:@"                                                                                                                                                                  "];
        
        // Separator 02
        self.separator02 = [self addSeparator];
        
        // Comment button
        self.btn_comment = [self addFUIButtonWithImage:[UIImage imageNamed:@"Comment_64x64"]];
        
        // Separator 03
        self.separator03 = [self addSeparator];
        
        // Map View
        self.mapView = [self addMapView];
        
        
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
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.width.mas_equalTo(ScreenWidth); // Need this. Nothing else specified the scrollview width
        }];
        
        // View Items
        [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
        }];
        
        // Host, Time Start, Location, Distance Text
        [self pinView:self.label_host toUpperview:self.label_title];
        [self pinView:self.label_timeStart toUpperview:self.label_host];
        [self pinView:self.label_location toUpperview:self.label_timeStart];
        [self pinView:self.label_distanceText toUpperview:self.label_location];
        
        // Join Buttons
        [self.btn_join mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_distanceText.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Default.left);
            //            make.size.mas_equalTo(CGSizeMake(50, 152));
            make.height.mas_equalTo(40);
        }];
        [self.btn_maybe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn_join.mas_top);
            make.left.equalTo(self.btn_join.mas_right).with.offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
            make.size.equalTo(self.btn_join);
        }];
        
        // Separator 01
        [self pinSeparator:self.separator01 toUpperview:self.btn_join];
        
        // Description Text View
        [self.textviewDescription mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separator01.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
            CGSize sizeFit = [self.textviewDescription sizeThatFits:CGSizeMake([self getTextViewDescriptionAdjustedWidth], MAXFLOAT)];
            make.height.mas_equalTo(sizeFit.height);
        }];
        
        // Separator 02
        [self pinSeparator:self.separator02 toUpperview:self.textviewDescription];
        
        // Comment button
        [self.btn_comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separator02.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.size.mas_equalTo(CGSizeMake(100, 40));
//            make.height.mas_equalTo(40);
        }];
        
        // Separator 03
        [self pinSeparator:self.separator03 toUpperview:self.btn_comment];
        
        // Map View
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separator03.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
            make.height.mas_equalTo(250);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(mas_Padding_Page_Default.right);
        }];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (CGFloat)getTextViewDescriptionAdjustedWidth
{
    return ScreenWidth - 2*mas_Padding_Page_Default.left;
}

- (void)pinView:(UIView *)view toUpperview:(UIView *)upperview
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Default.top);
        make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
        make.right.equalTo(self.contentView.mas_right).with.offset(mas_Padding_Page_Default.right);
        //        if ([view isMemberOfClass:[JVFloatLabeledTextField class]]) {
        //            make.height.mas_equalTo(40);
        //        } else {
        //            make.height.mas_equalTo(1);
        //        }
    }];
}

- (void)pinSeparator:(UIView *)view toUpperview:(UIView *)upperview
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Default.top);
        make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
        make.right.equalTo(self.contentView.mas_right).with.offset(mas_Padding_Page_Default.right);
        make.height.mas_equalTo(1);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"GCActivityDetailScrollView touchesBegan:withEvent:");
    [super touchesBegan:touches withEvent:event];
    // Don't let UIScrollView eats up all the touch events. Pass it to nextResponder
    [self.nextResponder touchesBegan: touches withEvent:event];
}

#pragma mark - Factory Methods
static const CGFloat kDetailViewFontSizeLarge = 18.0f;
static const CGFloat kDetailViewFontSizeSmall = 13.0f;
- (UILabel *)addLabelTitleWithString:(NSString *)title bold:(BOOL)isBold fontSize:(CGFloat)size
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

- (FUIButton *)addFUIButtonWithTitle:(NSString *)title
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    button.shadowColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
    button.shadowHeight = 1.0f;
    button.cornerRadius = 6.0f;
    button.titleLabel.font = [UIFont fontWithName:FontTheme01_Bold size:kDetailViewFontSizeLarge];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.contentView addSubview:button];
    return button;
}


- (FUIButton *)addFUIButtonWithImage:(UIImage *)image
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [UIColor clearColor];
    button.shadowColor = [UIColor clearColor];
    button.shadowHeight = 1.0f;
    button.cornerRadius = 6.0f;
    [button setImage:image forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.contentView addSubview:button];
    return button;
}

- (UIView *)addSeparator
{
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.contentView addSubview:separator];
    return separator;
}

- (UITextView *)addTextViewWithString:(NSString *)content
{
    UITextView *textView = [[UITextView alloc] init];
    textView.text = content;
    textView.selectable = YES;
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.tintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    textView.textColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    textView.font = [UIFont fontWithName:FontTheme01 size:kDetailViewFontSizeSmall];
    [self.contentView addSubview:textView];
    return textView;
}

- (MKMapView *)addMapView
{
    MKMapView * mapView = [[MKMapView alloc] init];
    
    mapView.mapType = MKMapTypeStandard;
    
    CLLocationCoordinate2D coord = (CLLocationCoordinate2D){.latitude = 61.2180556, .longitude = -149.9002778};
    mapView.centerCoordinate = coord;
    
    
    //        NSUInteger zoomLevel = MIN(zoomLevel, 28);
    //
    //        // use the zoom level to compute the region
    //        MKCoordinateSpan span = [self coordinateSpanWithMapView:self centerCoordinate:coord andZoomLevel:zoomLevel];
    //        MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    //
    //        // set the region like normal
    //        [self setRegion:region animated:animated];
    //    }
    
    ////        MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    //        MKCoordinateRegion region = {coord, span};
    //        mapView.region = region;
    //        map.delegate = self;
    
    [self.contentView addSubview:mapView];
    return mapView;
}

@end
