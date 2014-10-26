//
//  GCAppViewModel.h
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCAppViewModel : NSObject

// App Data

// Accessor for Singleton class
+ (GCAppViewModel *)sharedInstance;

#pragma mark - Log In
+ (void)loginWithCredential:(NSDictionary *)credential;
+ (void)enterMainContainerViewController:(UIViewController *)controller;

#pragma mark - Fetch Data
+ (BOOL)getCurrentActivitiesWithParameter:(NSDictionary *)parameter;


@end
