//
//  GCActivity.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventBasics.h"

@implementation GCEventBasics

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID": @"iduser",
             @"nameFirst": @"first_name",
             @"nameLast": @"last_name",
             @"phoneString": @"contact_phone",
             @"emailString": @"contact_email",
             
             @"eventID": @"idactivity",
             @"timeCreated": @"creation_time",
             @"timeUpdated": @"update_time",
             @"timeToStart": @"start_time",
             @"locationString": @"location",
             @"eventTitle": @"title",
             @"eventDescription": @"description",
             @"eventDuration": @"duration",
             @"countWatch": @"watcher_count",
             @"countParticipants": @"partitipant_count",
             @"distanceMeter": @"distance",
             @"distanceString": @"distanceText",
             
             @"shouldstickToTop": @"stick_to_top",
             @"isActiveEvent": @"active",
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
+ (NSValueTransformer *)eventIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)timeCreatedJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *timeString){
        return [self.dateFormatter dateFromString:timeString];
    }reverseBlock:^(NSDate *date){
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)timeUpdatedJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *timeString){
        return [self.dateFormatter dateFromString:timeString];
    }reverseBlock:^(NSDate *date){
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)timeToStartJSONTransformer
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

+ (NSValueTransformer *)eventTitleJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)eventDescriptionJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *string){
        return string;
    }reverseBlock:^(NSString *string){
        return string;
    }];
}

+ (NSValueTransformer *)eventDurationJSONTransformer
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
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *numberString){
        return [[[NSNumberFormatter alloc] init] numberFromString:numberString];
    }reverseBlock:^(NSNumber *number){
        return [NSString stringWithFormat:@"%@", number];
    }];
}

+ (NSValueTransformer *)isActiveEventJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *numberString){
        return [[[NSNumberFormatter alloc] init] numberFromString:numberString];
    }reverseBlock:^(NSNumber *number){
        return [NSString stringWithFormat:@"%@", number];
    }];
}


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



















