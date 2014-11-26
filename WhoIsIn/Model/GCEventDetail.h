//
//  GCEventDetail.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCEventDetail : MTLModel <MTLJSONSerializing>

// User


@property NSNumber *userID;
@property NSString *nameFirst;
@property NSString *nameLast;
@property NSString *phoneString;
@property NSString *emailString;
// Activity
@property NSNumber *eventID;
@property NSDate *timeCreated;
@property NSDate *timeUpdated;
@property NSDate *timeToStart;
@property NSString *locationString;
@property NSNumber *longitude;          // New
@property NSNumber *latitude;           // New
@property NSString *eventTitle;
@property NSString *eventDescription;
@property NSNumber *eventDuration;
@property NSNumber *countWatch;
@property NSNumber *countParticipants;
@property NSNumber *distanceMeter;
@property NSString *distanceString;
// State
@property BOOL shouldstickToTop;
@property BOOL isActiveEvent;









@end
