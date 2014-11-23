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
@property GCAppData *appData;
@property NSMutableArray *sortedEventsBasicsAll;
@property NSMutableArray *sortedEventsBasicsMy;

//@property 

#pragma mark - App data
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel;
+ (void)saveAppDataToNSUserDefaults;

#pragma mark - Log In & Register
+ (void)loginWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion;
+ (void)registerWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion;
+ (void)enterMainContainerViewController:(UIViewController *)controller;

#pragma mark - Fetch Data
+ (void)getEventsAllWithParameter:(NSDictionary *)parameter completion:(void (^)(BOOL succeeded))completion;
+ (void)getEventsMyWithParameter:(NSDictionary *)parameter completion:(void (^)(BOOL succeeded))completion;


@end
