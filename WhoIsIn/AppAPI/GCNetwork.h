//
//  GCNetwork.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCNetwork : NSObject

// GET
+ (void)requestGETWithURL:(NSURL *)url parameter:(NSMutableDictionary *)parameter completion:(void (^)(BOOL succeeded, NSData *data))completionBlock;
// POST
+ (void)requestPOSTWithURL:(NSURL *)url parameter:(NSMutableDictionary *)parameter completion:(void (^)(BOOL succeeded, NSData *data))completionBlock;


    
@end
