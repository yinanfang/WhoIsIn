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
             
             @"activityID": @"idactivity",
             @"timeCreation": @"creation_time",
             @"timeUpdate": @"update_time",
             @"timeStart": @"start_time",
             @"locationString": @"location",

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
        
        NSLog(@"timeString: %@", timeString);
        NSDateFormatter *dateFor = self.dateFormatter;
        NSLog(@"date formatter: %@", [dateFor description]);
        NSLog(@"date: %@", [self.dateFormatter dateFromString:timeString]);
        
        
        NSLog(@"test____");
        NSString *str = @"2012-10-30"; /// here this is your date with format yyyy-MM-dd
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

        [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
        NSDate *date = [dateFormatter dateFromString: str];
        NSLog(@"date11: %@", [date description]);
        
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        date = [dateFormatter dateFromString: @"2014-11-11 19:00:00"];
//        date = [dateFormatter dateFromString: timeString];

        NSLog(@"date22: %@", [date description]);
        
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
