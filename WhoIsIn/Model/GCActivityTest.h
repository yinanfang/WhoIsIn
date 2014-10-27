//
//  GCActivityTest.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCActivityTest : MTLModel <MTLJSONSerializing>

// User
@property NSNumber *userID;
@property NSString *nameFirst;
@property NSString *nameLast;
@property NSString *phoneString;
@property NSString *emailString;
// Activity
@property NSNumber *activityID;
@property NSDate *timeCreation;
@property NSDate *timeUpdate;
@property NSDate *timeStart;
@property NSString *locationString;
@property NSString *activityTitle;
@property NSString *activityDescription;
@property NSNumber *activityDuration;
@property NSNumber *countWatch;
@property NSNumber *countParticipants;
@property NSNumber *distanceMeter;
@property NSString *distanceString;
// State
@property BOOL shouldstickToTop;
@property BOOL isActiveActivity;

// Class property
+ (NSDateFormatter *)dateFormatter;

@end
