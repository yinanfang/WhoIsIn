//
//  GCActivityController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityController.h"

@implementation GCActivityController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize Variables
    self.view.backgroundColor = [UIColor blueColor];
    
    // Activity Scroll View
    self.activitScrollView = [UITableView new];
    self.activitScrollView.backgroundColor = [UIColor lightGrayColor];
    self.activitScrollView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.activitScrollView];
    [self updateViewConstraints];

    // Fetch Activities
//    [self fetchActivityDataWithParameter:nil];
    
    DDLogVerbose(@"test");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    [manager GET:@"https://story2movie.com/API201425PKS238K89DJK/service.php?method=getActivities&origin=35.749087%2C-78.885771&showExpired=0&sortBy=distance" parameters:nil success:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *firstObject = responseObject[0];
        NSLog(@"first object: %@", firstObject);
        NSLog(@"description: %@", firstObject[@"description"]);
        
        NSMutableDictionary *testObject = [NSMutableDictionary new];
        [testObject setValue:firstObject[@"first_name"] forKey:@"first_name"];
        [testObject setValue:firstObject[@"last_name"] forKey:@"last_name"];
        [testObject setValue:firstObject[@"contact_phone"] forKey:@"contact_phone"];
        [testObject setValue:firstObject[@"contact_email"] forKey:@"contact_email"];
        [testObject setValue:firstObject[@"idactivity"] forKey:@"idactivity"];
        [testObject setValue:firstObject[@"creation_time"] forKey:@"creation_time"];
        [testObject setValue:firstObject[@"update_time"] forKey:@"update_time"];
        [testObject setValue:firstObject[@"start_time"] forKey:@"start_time"];
        [testObject setValue:firstObject[@"location"] forKey:@"location"];
        [testObject setValue:firstObject[@"title"] forKey:@"title"];
        [testObject setValue:firstObject[@"description"] forKey:@"description"];
        [testObject setValue:firstObject[@"watcher_count"] forKey:@"watcher_count"];
        [testObject setValue:firstObject[@"partitipant_count"] forKey:@"partitipant_count"];
        [testObject setValue:firstObject[@"distance"] forKey:@"distance"];
        [testObject setValue:firstObject[@"distanceText"] forKey:@"distanceText"];
        [testObject setValue:firstObject[@"stick_to_top"] forKey:@"stick_to_top"];
        [testObject setValue:firstObject[@"active"] forKey:@"active"];


        
        NSLog(@"test object: %@", testObject);
        
        NSError *error;
        GCActivity *activity = [MTLJSONAdapter modelOfClass:[GCActivity class] fromJSONDictionary:responseObject[0] error:&error];
        if (error) {
            NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
        }
        DDLogVerbose(@"activity value: %@", [MTLJSONAdapter JSONDictionaryFromModel:activity]);
        
//        NSError *error;
//        GCActivity *activity = [MTLJSONAdapter modelOfClass:[GCActivity class] fromJSONDictionary:firstObject error:&error];
//        if (error) {
//            NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
//        }
//        DDLogVerbose(@"appData Current value: %@", activity);
        
        
        
//        NSError *error;
//        NSArray *activities = [MTLJSONAdapter modelsOfClass:[GCActivity class] fromJSONArray:responseObject error:&error];
//        if (error) {
//            NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
//        }
//        DDLogVerbose(@"appData Current value: %@", activities);
        
        
        
//        NSArray *activities = [MTLJSONAdapter modelsOfClass:[GCActivity class] fromJSONArray:responseObject error:&error];
//        if (error) {
//            NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
//            return nil;
//        }
        
//        NSLog(@"%@", [NSString stringWithCString:[responseObject[0][@"description"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)fetchActivityDataWithParameter:(NSDictionary *)parameter
{
    DDLogVerbose(@"fetchActivityDataWithParameter");
    if (!parameter) {
        // Fetch default activity list
        parameter = @{
                      @"method": @"getActivities",
                      @"sortBy": @"distance",
                      @"origin": @"35.749087,-78.885771",
                      @"showExpired": @"0",
                      };
        BOOL shouldReloadTable = [GCAppViewModel getCurrentActivitiesWithParameter:parameter];
        if (shouldReloadTable) {
            DDLogVerbose(@"shouldReloadTable");
            [self.activitScrollView reloadData];
        }
    }
}



- (void)updateViewConstraints
{
    DDLogVerbose(@"GCActivityController updateViewConstraints");
    [GCAppSetup setConstraints_FillFullScreenWithView:self.activitScrollView superview:self.view];
    
    [super updateViewConstraints];
}







@end
