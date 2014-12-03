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
    NSString *msg = [logMessage->_message stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    //Alter the message to your liking
    NSString *logLevel;
    switch (logMessage->_flag)
    {
        case DDLogFlagError  : logLevel = @"E"; break;
        case DDLogFlagWarning   : logLevel = @"W"; break;
        case DDLogFlagInfo   : logLevel = @"I"; break;
        case DDLogFlagDebug : logLevel = @"D"; break;
        default              : logLevel = @"V"; break;
    }
    
    // Format time
    NSString *time = [[GCAppAPI dateFormatter04] stringFromDate:logMessage->_timestamp];
    
    //Format the message for the server-side log file parser
    return [NSString stringWithFormat:@"%@ [%@] %@", time, logLevel, msg];
}
@end

@implementation CustomLogFormatters02
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    //Alter the message to your liking
    NSString *msg = [logMessage->_message stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    NSString *logLevel;
    switch (logMessage->_flag)
    {
        case DDLogFlagError  : logLevel = @"E"; break;
        case DDLogFlagWarning   : logLevel = @"W"; break;
        case DDLogFlagInfo   : logLevel = @"I"; break;
        case DDLogFlagDebug : logLevel = @"D"; break;
        default              : logLevel = @"V"; break;
    }
    
    //Also display the file the logging occurred in to ease later debugging
    NSString *file = [[logMessage->_file lastPathComponent] stringByDeletingPathExtension];
    
    //Format the message for the server-side log file parser
    return [NSString stringWithFormat:@"%@ %@ %@ %@ || [%@@%@@%lu]", logMessage->_timestamp, logMessage->_threadID, logLevel, msg, file, logMessage->_function, (unsigned long)logMessage->_line];
}
@end
