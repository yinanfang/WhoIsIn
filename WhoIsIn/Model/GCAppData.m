//
//  GCAppData.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppData.h"

@implementation GCAppData

- (instancetype)init
{
    DDLogVerbose(@"Initializing GCAppData...");
    self = [super init];
    if (self) {
        self.currentUser = [[GCUser alloc] init];
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"currentUser": @"currentUser",
             };
}

+ (NSValueTransformer *)currentUserJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GCUser class]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
