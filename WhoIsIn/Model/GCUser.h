//
//  GCUser.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCUser : MTLModel <MTLJSONSerializing>

typedef NS_ENUM(NSInteger, GCGender) {
    GCGenderMale,
    GCGenderFemale
};

@property NSNumber *userID;
@property NSString *email;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *phoneNumber;
@property GCGender gender;
@property BOOL isActive;


@end
