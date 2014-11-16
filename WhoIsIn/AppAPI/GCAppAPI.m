//
//  GCAppAPI.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppAPI.h"
#import <CommonCrypto/CommonDigest.h>   // For calculating MD5

@implementation GCAppAPI

#pragma mark - Singleton Class
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
    DDLogVerbose(@"Initializing GCAppAPI...");
    self = [super init];
    if (self) {
        // Initialize values
        
        
    }
    return self;
}

#pragma mark - Basic Utilities
+ (NSString *)getCurrentDomain
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *current_domain = [defaults objectForKey:@"current_domain"];
    return current_domain;
}

+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color
{    
    return [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f
                           green:((color >> 16) & 0xFF) / 255.0f
                            blue:((color >> 8) & 0xFF) / 255.0f
                           alpha:((color) & 0xFF) / 255.0f];
}

+ (void)setHasShownTour:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:NSUserDefaultsKeyForDidShownTour];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)didRunAppBefore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL didRunAppBefore = [defaults boolForKey:NSUserDefaultsKeyForDidRunAppBefore];
    return didRunAppBefore ? YES : NO;
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

+ (CGSize)getSizeOfStatusbar:(UIViewController *)controller
{
    CGFloat statusBarHeight = 0.000000;
    UIInterfaceOrientation orientation_StatusBar = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation_StatusBar) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"It's UIInterfaceOrientationPortrait");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"It's UIInterfaceOrientationLandscape");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
            break;
        default:
            break;
    }
    return CGSizeMake(ScreenWidth, statusBarHeight);
}

+ (CGSize)getSizeOfNavigationBar:(UIViewController *)controller
{
    return controller.navigationController.navigationBar.frame.size;
}

+ (CGSize)getSizeOfStatusbarAndNavigationBar:(UIViewController *)controller
{
    CGFloat statusBarHeight = 0.000000;
    CGFloat navBarHeight = controller.navigationController.navigationBar.frame.size.height;
    UIInterfaceOrientation orientation_StatusBar = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation_StatusBar) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"It's UIInterfaceOrientationPortrait");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"It's UIInterfaceOrientationLandscape");
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.width;
            break;
        default:
            break;
    }
    return CGSizeMake(ScreenWidth, statusBarHeight+navBarHeight);
}

+ (CGRect)getScreenBoundsDependOnOrientation
{
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    if(IS_IOS8){
        return screenBounds ;
    }
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds ;
}

+ (NSString *)getMD5StringWithString:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

#pragma mark - Mantle
+ (id)getMantleModelWithDictionary:(NSDictionary *)dictionary modelClass:(Class)modelClass
{
    NSError *mantleError = nil;
    id model = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:dictionary error:&mantleError];
    DDLogVerbose([model description]);
    if (mantleError) {
        DDLogWarn(@"Cannot generate GCUser model!!!");
    }
    return model;
}

















@end
