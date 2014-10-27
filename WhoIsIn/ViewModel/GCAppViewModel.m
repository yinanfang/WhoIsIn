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
+ (BOOL)getCurrentActivitiesWithParameter:(NSDictionary *)parameter
{
    DDLogVerbose(@"getCurrentActivities");
    NSURL *url = [NSURL URLWithString:URLToServicePHP];
//    [GCNetwork requestGETWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data){
//        if (succeeded) {
//            DDLogVerbose(@"Generating GCAvtivity object...");
//            NSArray *jsonArray = (NSArray *)data;
//            NSError *error;
//            NSArray *activities = [MTLJSONAdapter modelsOfClass:[GCActivity class] fromJSONArray:jsonArray error:&error];
//            if (error) {
//                NSLog(@"Couldn't convert app infos JSON to GCActivity models: %@", error);
//            }
//            DDLogVerbose(@"GCActivity value: %@", activities);
//            
//        }
//    }];
    
//    DDLogVerbose(@"test");
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    [manager GET:@"https://story2movie.com/API201425PKS238K89DJK/service.php?method=getActivities&origin=35.749087%2C-78.885771&showExpired=1&sortBy=distance" parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        
//        NSError *error;
//        NSArray *activities = [MTLJSONAdapter modelsOfClass:[GCActivity class] fromJSONArray:responseObject error:&error];
//        if (error) {
//            NSLog(@"Couldn't convert app infos JSON to GCActivity models: %@", error);
//        }
//        DDLogVerbose(@"GCActivity value: %@", activities);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    
    return NO;
}
/*

*/
@end
