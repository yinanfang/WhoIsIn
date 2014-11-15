//
//  GCActivityController.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCActivityController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIToolbarDelegate>

@property UITableView *activityTableView;

// Segment Control
@property UISegmentedControl *sortControl;


@end
