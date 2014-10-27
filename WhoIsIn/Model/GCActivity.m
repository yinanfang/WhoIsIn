//
//  GCActivity.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivity.h"

@implementation GCActivity

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID": @"iduser",
             @"nameFirst": @"first_name",
             @"nameLast": @"last_name",
             @"phoneString": @"contact_phone",
             @"emailString": @"contact_email",
             
             @"activityID": @"idactivity",
             @"timeCreation": @"creation_time",
             @"timeUpdate": @"update_time",
             @"timeStart": @"start_time",
             @"locationString": @"location",
             @"activityTitle": @"title",
             @"activityDescription": @"description",
             @"activityDuration": @"duration",
             @"countWatch": @"watcher_count",
             @"countParticipants": @"partitipant_count",
             @"distanceMeter": @"distance",
             @"distanceString": @"distanceText",
             
             @"shouldstickToTop": @"stick_to_top",
             @"isActiveActivity": @"active",
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

// Activity
+ (NSValueTransformer *)activityIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)timeCreationJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *timeString){
        return [self.dateFormatter dateFromString:timeString];
    }reverseBlock:^(NSDate *date){
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)timeUpdateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *timeString){
        return [self.dateFormatter dateFromString:timeString];
    }reverseBlock:^(NSDate *date){
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)timeStartJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *timeString){
        return [self.dateFormatter dateFromString:timeString];
    }reverseBlock:^(NSDate *date){
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)locationStringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)activityTitleJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)activityDescriptionJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)activityDurationJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)countWatchJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)countParticipantsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)distanceMeterJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)distanceStringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

// State
+ (NSValueTransformer *)shouldstickToTopJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)isActiveActivityJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}
// TODO: Can't use BOOL transformer
// return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];

+ (NSDateFormatter *)dateFormatter {
    
    static NSDateFormatter *kDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kDateFormatter = [[NSDateFormatter alloc] init];
        kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        kDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";  // you configure this based on the strings that your webservice uses!!
    });
    return kDateFormatter;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end



















