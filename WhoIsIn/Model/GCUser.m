//
//  GCUser.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCUser.h"

@implementation GCUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID": @"iduser",
             @"email": @"email",
             @"firstName": @"first_name",
             @"lastName": @"last_name",
             @"phoneNumber": @"phone_number",
             @"gender": @"gender",
             @"isActive": @"active",
             };
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return [[[NSNumberFormatter alloc] init] numberFromString:str];
    }reverseBlock:^(NSNumber *num){
        return [NSString stringWithFormat:@"%@", num];
    }];
}

+ (NSValueTransformer *)emailJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)firstNameJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)lastNameJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)phoneNumberJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)genderJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        if ([str isEqualToString:@"M"]) {
            return @(GCGenderMale);
        } else {
            return @(GCGenderFemale);
        }
    }reverseBlock:^(NSNumber *gender){
        if ([gender integerValue] == GCGenderMale) {
            return @"M";
        } else {
            return @"F";
        }
    }];
}

+ (NSValueTransformer *)isActiveJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return [[[NSNumberFormatter alloc] init] numberFromString:str];
    }reverseBlock:^(NSNumber *num){
        return [NSString stringWithFormat:@"%@", num];
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
