//
//  GCAppData.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCAppData : MTLModel <MTLJSONSerializing>

@property GCUser *currentUser;


@end
