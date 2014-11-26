//
//  GCEventDetail.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventDetail.h"

@implementation GCEventDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             // User
             @"userID": @"activity.0.iduser",
             @"nameFirst": @"activity.0.first_name",
             @"nameLast": @"activity.0.last_name",
             @"phoneString": @"activity.0.contact_phone",
             @"emailString": @"activity.0.contact_email",
             
             @"eventID": @"activity.0.idactivity",
             @"timeCreated": @"activity.0.creation_time",
             @"timeUpdated": @"activity.0.update_time",
             @"timeToStart": @"activity.0.start_time",
             @"locationString": @"activity.0.location",
             @"longitude": @"activity.0.lng",
             @"latitude": @"activity.0.lat",
             @"eventTitle": @"activity.0.title",
             @"eventDescription": @"activity.0.description",
             @"eventDuration": @"activity.0.duration",
             @"countWatch": @"activity.0.watcher_count",
             @"countParticipants": @"activity.0.participant_count",
             @"distanceMeter": @"activity.0.distance",
             @"distanceString": @"activity.0.distanceText",
             
             @"shouldstickToTop": @"activity.0.stick_to_top",
             @"isActiveEvent": @"activity.0.active",
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

+ (NSValueTransformer *)longitudeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
    }];
}

+ (NSValueTransformer *)latitudeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *number){
        return number;
    }reverseBlock:^(NSNumber *number){
        return number;
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