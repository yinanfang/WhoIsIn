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

// Cover
+ (void)loginWithCredential:(NSDictionary *)credential;
//+ (void)registerWithCredential:(NSDictionary *)credential;

+ (void)enterMainContainerViewController:(UIViewController *)controller;



@end
