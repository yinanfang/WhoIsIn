//
//  GCEventDetailScrollView.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCEventDetailViewController;

@interface GCEventDetailScrollView : UIScrollView

// Self
@property GCEventDetailViewController *parentController;
@property BOOL didSetupConstraints;

#pragma mark -  Content
@property UIView *contentView;
// Event
@property UILabel *label_title;
@property UILabel *label_host;
@property UILabel *label_timeStart;
@property UILabel *label_location;
@property UILabel *label_distanceText;

@property FUIButton *btn_join;
@property FUIButton *btn_maybe;

@property UIView *separator01;

@property UITextView *textviewDescription;

@property UIView *separator02;

@property FUIButton *btn_comment;

@property UIView *separator03;

@property MKMapView *mapView;


// Participants
@property UILabel *label_participants;
@property UITableView *tableParticipants;


// Discussion
@property UILabel *label_discussion;
@property UITableView *tableDiscussion;


#pragma mark - View Method
- (instancetype)initWithParentController:(GCEventDetailViewController *)controller;
- (CGFloat)getTextViewDescriptionAdjustedWidth;

@end
