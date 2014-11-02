//
//  GCAppViewModel.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCAppViewModel : NSObject

// Accessor for Singleton class
+ (GCAppViewModel *)sharedInstance;

// App Data
@property NSMutableArray *sortedActivities;

#pragma mark - Log In
+ (void)loginWithCredential:(NSDictionary *)credential;
+ (void)enterMainContainerViewController:(UIViewController *)controller;

#pragma mark - Fetch Data
+ (void)getCurrentActivitiesWithParameter:(NSDictionary *)parameter completion:(void (^)(BOOL succeeded))completion;


@end
