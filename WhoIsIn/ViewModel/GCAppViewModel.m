//
//  GCAppViewModel.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/19/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppViewModel.h"
#import "GCMainContainerViewController.h"

@implementation GCAppViewModel

#pragma mark - Singleton Class
+ (GCAppViewModel *)sharedInstance
{
    static GCAppViewModel *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
        DDLogVerbose(@"Initialized GCAppViewModel share instance. Current value: %@", [shareInstance description]);
    });
    return shareInstance;
}

- (instancetype)init
{
    DDLogVerbose(@"Initializing GCAppDataViewModel...");
    self = [super init];
    if (self) {
        // Initialize values
        self.appData = [[GCAppData alloc] init];
        self.sortedEventsBasicsAll = [[NSMutableArray alloc] init];
        self.sortedEventsBasicsMy = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - App data
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel
{
    DDLogVerbose(@"Getting app data...");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *appData_encoded = [defaults objectForKey:NSUserDefaultsKeyForAppData];
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    if (appData_encoded) {
        DDLogVerbose(@"Updating app data...");
        GCAppData *appData_decoded = [NSKeyedUnarchiver unarchiveObjectWithData:appData_encoded];
        appViewModel.appData = appData_decoded;
        DDLogVerbose(@"appData Current value: %@", appViewModel.appData);
    } else {
        DDLogVerbose(@"There's not appData...");
    }
    DDLogVerbose(@"Finished updating GCAppViewModel");
}

+ (void)saveAppDataToNSUserDefaults
{
    DDLogVerbose(@"Saving app data...");
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    DDLogVerbose(@"App Data Current value: %@", [appViewModel.appData description]);
    DDLogVerbose(@"App Data CurrentUser Current valuein JSON: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData.currentUser]);
    NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
    [defaults synchronize];
}

#pragma mark - Log In & Register
+ (void)loginWithCredential:(NSMutableDictionary *)credential completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"start to login...");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    credential[@"method"] = @"login";
    [GCNetwork requestGETWithURL:url parameter:credential completion:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            NSDictionary *userDic = (NSDictionary *)data;
            if ([userDic[@"iduser"] isEqualToString:@"0"]) {
                DDLogVerbose(@"Rejected");
                completion(NO);
            } else {
                DDLogVerbose(@"Logged in successfully");
                // Init GCUser
                NSError *error = nil;
                GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDic error:&error];
                DDLogVerbose(@"user object: %@", [user description]);
                if (error) {
                    DDLogWarn(@"Cannot generate GCUser model!!!");
                }
                [GCAppViewModel sharedInstance].appData.currentUser = user;
                completion(YES);
            }
        }
    }];
}

+ (void)registerWithCredential:(NSMutableDictionary *)credential completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"start to login...");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    credential[@"method"] = @"signup";
    [GCNetwork requestPOSTWithURL:url parameter:credential completion:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            NSDictionary *userDic = (NSDictionary *)data;
            if ([userDic[@"response"] isEqualToString:@"0"]) {
                DDLogVerbose(@"Register failed...");
                completion(NO);
            } else {
                DDLogVerbose(@"Registered successfully!");
                // Init GCUser
                NSError *error = nil;
                GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDic error:&error];
                DDLogVerbose(@"user object: %@", [user description]);
                if (error) {
                    DDLogWarn(@"Cannot generate GCUser model!!!");
                }
                [GCAppViewModel sharedInstance].appData.currentUser = user;
                completion(YES);
            }
        }
    }];
}

+ (void)enterMainContainerViewController:(UIViewController *)controller
{
    GCMainContainerViewController *mainContainerViewController = [[GCMainContainerViewController alloc] init];
    [controller.navigationController pushViewController:mainContainerViewController animated:YES];
}

#pragma mark - Fetch Data
+ (void)getEventsAllWithParameter:(NSMutableDictionary *)parameter completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"getCurrentActivities");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data){
        if (succeeded) {
            DDLogVerbose(@"Generating GCEvent object...");
            NSError *error;
            NSArray *jsonArray = (NSArray *)data;
            NSArray *eventArray = [MTLJSONAdapter modelsOfClass:[GCEventBasics class] fromJSONArray:jsonArray error:&error];
            [GCAppViewModel sharedInstance].sortedEventsBasicsAll = [eventArray mutableCopy];
            if (error) {
                DDLogVerbose(@"Couldn't convert JSON to GCEvent models: %@", error);
            }
//            DDLogVerbose(@"activities new value: %@", eventArray);
            DDLogVerbose(@"activities new count: %lu", (unsigned long)[eventArray count]);
            completion(YES);
        }
    }];
}

+ (void)getEventsMyWithParameter:(NSMutableDictionary *)parameter completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"getCurrentActivities");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data){
        if (succeeded) {
            DDLogVerbose(@"Generating GCEvent object...");
            NSError *error;
            NSArray *jsonArray = (NSArray *)data;
            NSArray *eventArray = [MTLJSONAdapter modelsOfClass:[GCEventBasics class] fromJSONArray:jsonArray error:&error];
            [GCAppViewModel sharedInstance].sortedEventsBasicsMy = [eventArray mutableCopy];
            if (error) {
                DDLogVerbose(@"Couldn't convert JSON to GCEvent models: %@", error);
            }
            //            DDLogVerbose(@"activities new value: %@", eventArray);
            DDLogVerbose(@"activities new count: %lu", (unsigned long)[eventArray count]);
            completion(YES);
        }
    }];
}

+ (void)getEventDetailWithParameter:(NSMutableDictionary *)parameter completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"getCurrentActivities");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data){
        if (succeeded) {
            DDLogVerbose(@"Generating GCEvent object...");
            NSError *error;
            NSArray *jsonArray = (NSArray *)data;
            NSArray *eventArray = [MTLJSONAdapter modelsOfClass:[GCEventBasics class] fromJSONArray:jsonArray error:&error];
            [GCAppViewModel sharedInstance].sortedEventsBasicsMy = [eventArray mutableCopy];
            if (error) {
                DDLogVerbose(@"Couldn't convert JSON to GCEvent models: %@", error);
            }
            //            DDLogVerbose(@"activities new value: %@", eventArray);
            DDLogVerbose(@"activities new count: %lu", (unsigned long)[eventArray count]);
            completion(YES);
        }
    }];
}





@end
