//
//  GCActivityTest.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityTest.h"

@implementation GCActivityTest

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID": @"iduser",
             @"nameFirst": @"first_name",
             @"nameLast": @"last_name",
             @"phoneString": @"contact_phone",
             @"emailString": @"contact_email",
             

             };
}

// User
+ (NSValueTransformer *)userIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)nameFirstJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)nameLastJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)phoneStringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)emailStringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
