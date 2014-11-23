//
//  GCActivityTableViewCell.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/2/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCEventTableViewCell : UITableViewCell

// Self
@property (assign) BOOL didSetupConstraints;

// Cell item
@property UILabel *label_title;

@property UILabel *label_timeStart;
@property UILabel *label_location;
@property UILabel *label_distanceText;

@property UILabel *label_participantAndWatcher;



@end
