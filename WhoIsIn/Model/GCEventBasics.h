//
//  GCActivity.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCEventBasics : MTLModel <MTLJSONSerializing>

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


/*
 
 "idactivity":"1",
 "creation_time":"2014-09-11 16:40:03",
 "update_time":null,
 "start_time":"2014-09-14 09:00:00",
 "location":"6446 Tryon Rd, Cary, NC 27518",
 "title":"Join us for Karaoke time!",
 "description":"Please join us for great time. We have large selction of drinks and KTV songs for you to join and show us what a great singer you are. Come on guys, it's go BIG time ^$%%^_^ ",
 "stick_to_top":"0",
 "contact_phone":"919-898-9989",
 "contact_email":"sckclark@gmail.com",
 "iduser":"1",
 "duration":"60",
 "active":"1",
 "first_name":"JI", //This is creator’s first name.
 "last_name":"ZHAO", //This is creator’s last name.
 "watcher_count":"0",
 "partitipant_count":"2",
 "distance":12951,
 "distanceText":"8.0 mi"
 
 */
@end























