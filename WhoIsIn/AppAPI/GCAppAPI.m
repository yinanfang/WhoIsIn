//
//  GCAppAPI.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppAPI.h"

@implementation GCAppAPI

+ (GCAppAPI *)sharedInstance
{
    static GCAppAPI *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    DDLogVerbose(@"Initializing GCAppUtility...");
    self = [super init];
    if (self) {
        // Initialize values
        
        // Set up the GalleryImageWidth and GalleryImageHeight according to device height
        
    }
    return self;
}


#pragma mark - Basic Setup
+ (void)setupApplicationWithProductionMode:(BOOL)mode
{
    // Logging
    [self setupLogging];
    DDLogInfo(@"====================  Application Setup Started  ====================");
    
    // Cache
    [self setCachePolicy];
    
    // Domain
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (mode) {
        DDLogInfo(@"In PRODUCTION mode with domain: %@", ProductionDomain);
        [defaults setObject:ProductionDomain forKey:@"current_domain"];
    }else {
        DDLogInfo(@"In Development mode with domain: %@", DevelopmentDomain);
        [defaults setObject:DevelopmentDomain forKey:@"current_domain"];
    }
}

+ (void)setCachePolicy
{
    // Disable Cache for the networking methods
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

+ (void)setupLogging
{
    // DDTTYLogger
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // And then enable colors
    // Add Environment Variable in "Edit scheme": XcodeColors YES
    // Follow the Issue Report: https://github.com/CocoaLumberjack/CocoaLumberjack/issues/50#issuecomment-34286656
    // Enables XcodeColors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // Set logger color
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor purpleColor] backgroundColor:nil forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blackColor] backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor grayColor] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    // Test logger color
    DDLogError(@"DDLogError");
    DDLogWarn(@"DDLogWarn");
    DDLogInfo(@"DDLogInfo");
    DDLogDebug(@"DDLogDebug");
    DDLogVerbose(@"DDLogVerbose");
    DDLogTest(@"LogTest for XcodeColors");
    
    // DDASLLogger
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    [fileLogger setRollingFrequency:60 * 60 * 24];   // roll every day
    [fileLogger setMaximumFileSize:1024 * 1024 * 2]; // max 2mb file size
    [fileLogger.logFileManager setMaximumNumberOfLogFiles:7];
    [fileLogger setLogFormatter:[[CustomLogFormatters alloc] init]];
    
    [DDLog addLogger:fileLogger];
    DDLogInfo(@"Logging is setup (\"%@\")", [fileLogger.logFileManager logsDirectory]);
    
}

+ (NSString *)getCurrentDomain
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *current_domain = [defaults objectForKey:@"current_domain"];
    return current_domain;
}

#pragma mark - Others
+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color
{
    DDLogVerbose(@"... Invoked UtilityClass.colorWithRGBAinHex ...");
    
    return [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f
                           green:((color >> 16) & 0xFF) / 255.0f
                            blue:((color >> 8) & 0xFF) / 255.0f
                           alpha:((color) & 0xFF) / 255.0f];
}

+ (void)setHasShownTour:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:HasShownTour];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIImageView *)getFullScreenImageView:(NSString *)name
{
    UIImage *image;
    if (IS_IPHONE4S) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@@2x.png", name]];
    }else if (IS_IPHONE5S){
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@@R4.png", name]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    return imageView;
}

+ (CGPoint)getCGPointZeroWithStatusbarAndNavigationBar:(UIViewController *)controller
{
    CGFloat statusBarHeight = 0.000000;
    CGFloat navBarHeight = 0.000000;
    UIInterfaceOrientation orientation_StatusBar = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation_StatusBar) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"It's UIInterfaceOrientationPortrait");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            navBarHeight = controller.navigationController.navigationBar.frame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"It's UIInterfaceOrientationLandscape");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
            navBarHeight = controller.navigationController.navigationBar.frame.size.height;
            break;
        default:
            break;
    }
    return CGPointMake(0, -statusBarHeight-navBarHeight);
}

@end
