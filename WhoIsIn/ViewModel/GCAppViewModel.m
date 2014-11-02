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

- (id)init
{
    DDLogVerbose(@"Initializing GCAppDataViewModel...");
    self = [super init];
    if (self) {
        // Initialize values
    }
    return self;
}

#pragma mark - Log In
+ (void)loginWithCredential:(NSDictionary *)credential
{
    DDLogVerbose(@"start to login...");
}


+ (void)enterMainContainerViewController:(UIViewController *)controller
{
    GCMainContainerViewController *mainContainerViewController = [[GCMainContainerViewController alloc] init];
    [controller.navigationController pushViewController:mainContainerViewController animated:YES];
}

#pragma mark - Fetch Data
+ (void)getCurrentActivitiesWithParameter:(NSDictionary *)parameter completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"getCurrentActivities");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data){
        if (succeeded) {
            DDLogVerbose(@"Generating GCAvtivity object...");
            NSArray *jsonArray = (NSArray *)data;
            NSError *error;
            NSArray *activities = [MTLJSONAdapter modelsOfClass:[GCActivity class] fromJSONArray:jsonArray error:&error];
            [GCAppViewModel sharedInstance].sortedActivities = [activities mutableCopy];
            if (error) {
                NSLog(@"Couldn't convert app infos JSON to GCActivity models: %@", error);
            }
            DDLogVerbose(@"GCActivity value: %@", activities);
            completion(YES);
        }
    }];
}









@end
