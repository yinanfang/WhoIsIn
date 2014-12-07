//
//  GCCustomLogFormatters.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCustomLogFormatters.h"

@implementation CustomLogFormatters01
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    //Alter the message to your liking
//    NSString *msg = [logMessage->logMsg stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    //Alter the message to your liking
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR  : logLevel = @"E"; break;
        case LOG_FLAG_WARN   : logLevel = @"W"; break;
        case LOG_FLAG_INFO   : logLevel = @"I"; break;
        case LOG_LEVEL_DEBUG : logLevel = @"D"; break;
        default              : logLevel = @"V"; break;
    }
    
    // Format time
    NSString *time = [[GCAppAPI dateFormatter04] stringFromDate:logMessage->timestamp];
    
    //Format the message for the server-side log file parser
    return [NSString stringWithFormat:@"%@ [%@] %@", time, logLevel, logMessage->logMsg];
}
@end

@implementation CustomLogFormatters02
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    //Alter the message to your liking
//    NSString *msg = [logMessage->logMsg stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR  : logLevel = @"E"; break;
        case LOG_FLAG_WARN   : logLevel = @"W"; break;
        case LOG_FLAG_INFO   : logLevel = @"I"; break;
        case LOG_LEVEL_DEBUG : logLevel = @"D"; break;
        default              : logLevel = @"V"; break;
    }
    
    //Also display the file the logging occurred in to ease later debugging
    NSString *file = [[[NSString stringWithUTF8String:logMessage->file] lastPathComponent] stringByDeletingPathExtension];
    
    //Format the message for the server-side log file parser
    return [NSString stringWithFormat:@"%@ %x %@ %@ || [%@@%s@%lu]", logMessage->timestamp, logMessage->machThreadID, logLevel, logMessage->logMsg, file, logMessage->function, (unsigned long)logMessage->lineNumber];
}
@end
