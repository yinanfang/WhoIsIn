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
        self.sortedEvent = [[NSMutableArray alloc] init];
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
+ (void)loginWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"start to login...");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    NSMutableDictionary *parameter = [credential mutableCopy];
    parameter[@"method"] = @"login";
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data) {
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

+ (void)registerWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"start to register...");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    NSMutableDictionary *parameter = [credential mutableCopy];
    parameter[@"method"] = @"signup";
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            NSDictionary *dataDic = (NSDictionary *)data;
            if ([dataDic[@"response"] isEqualToString:@"0"]) {
                DDLogVerbose(@"Register failed!");
                completion(NO);
            } else if ([dataDic[@"response"] isEqualToString:@"1"]) {
                DDLogVerbose(@"Register succeeded!");
                // Get user object
                
//                // Init GCUser
//                NSError *error = nil;
//                GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDic error:&error];
//                DDLogVerbose(@"user object: %@", [user description]);
//                if (error) {
//                    DDLogWarn(@"Cannot generate GCUser model!!!");
//                }
//                [GCAppViewModel sharedInstance].appData.currentUser = user;
//                completion(YES);
                
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
+ (void)getEventsWithParameter:(NSDictionary *)parameter completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"getCurrentActivities");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data){
        if (succeeded) {
            DDLogVerbose(@"Generating GCEvent object...");
            NSError *error;
            NSArray *jsonArray = (NSArray *)data;
            NSArray *eventArray = [MTLJSONAdapter modelsOfClass:[GCEvent class] fromJSONArray:jsonArray error:&error];
            [GCAppViewModel sharedInstance].sortedEvent = [eventArray mutableCopy];
            if (error) {
                DDLogVerbose(@"Couldn't convert JSON to GCEvent models: %@", error);
            }
            DDLogVerbose(@"activities new value: %@", eventArray);
            DDLogVerbose(@"activities new count: %lu", (unsigned long)[eventArray count]);
            completion(YES);

            // Generate using Dictionary
//            NSDictionary *jsonDictionary = (NSDictionary *)data;
//            NSMutableArray *sortedActivities = [GCAppViewModel sharedInstance].sortedActivities;
//            NSInteger count = [jsonDictionary count];
//            NSString *countString;
//            DDLogVerbose(@"Generating %li new GCAvtivity object...", (long)count);
//            for (NSInteger i = 0; i < count; i++) {
//                countString = [NSString stringWithFormat:@"%li", (long)i];
//                GCActivity *activity = [MTLJSONAdapter modelOfClass:[GCActivity class] fromJSONDictionary:jsonDictionary[countString] error:&error];
//                if (error) {
//                    DDLogVerbose(@"Error generating GCActivity: %@", error);
//                } else {
//                    DDLogVerbose(@"activity item: %@", activity);
//                    [sortedActivities addObject:activity];
//                }
//            }
//            DDLogVerbose(@"sortedActivities value: %@", sortedActivities);
//            DDLogVerbose(@"sortedActivities count: %lu", (unsigned long)[sortedActivities count]);
        }
    }];
}









@end
