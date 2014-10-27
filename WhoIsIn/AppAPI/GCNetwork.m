//
//  GCNetwork.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNetwork.h"

@implementation GCNetwork

+ (void)requestGETWithURL:(NSURL *)url parameter:(NSDictionary *)parameter completion:(void (^)(BOOL succeeded, NSData *responseData))completionBlock
{
    DDLogVerbose(@"url is: %@", url.absoluteString);
    DDLogVerbose(@"parameter: %@", parameter);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:url.absoluteString parameters:parameter success:^(AFHTTPRequestOperation *operation, NSData *data) {
        DDLogInfo(@"Get data successfully. Printing response data: %@", data);
        completionBlock(YES, data);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogWarn(@"Error: %@", error);
        // Customize error response
        if ([operation.response statusCode] == 409) {
            DDLogError(@"Email has already been registered");
        } else {
            DDLogError(@"Here's the error");
        }
        completionBlock(NO, nil);
    }];
}
@end
