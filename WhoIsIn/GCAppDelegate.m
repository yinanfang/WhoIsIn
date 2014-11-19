//
//  AppDelegate.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/5/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppDelegate.h"
#import "GCSignInViewController.h"
#import "GCMainContainerViewController.h"

@interface GCAppDelegate ()

@end

@implementation GCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GCAppSetup setupApplicationWithProductionMode:YES];
    DDLogVerbose(@"didFinishLaunchingWithOptions");
    [GCAppViewModel getAppDataFromNSUserDefaultsAndUpdateViewModel];
    
    // Set up window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Set global tint color
    [self.window setTintColor:[UIColor whiteColor]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    self.window.rootViewController = navigationController;
    GCSignInViewController *signInViewController = [[GCSignInViewController alloc] init];
    [navigationController pushViewController:signInViewController animated:NO];
    // Check if logged in before
    if ([GCAppViewModel sharedInstance].appData.currentUser.userID != nil) {
        DDLogVerbose(@"Logged In...");
        [navigationController pushViewController:[[GCMainContainerViewController alloc] init] animated:NO];
    }
    [self.window makeKeyAndVisible];
    
    // Push Notification Configuration
    DDLogInfo(@"Register for Push Notification!");
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    } else {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    return YES;
}

#pragma mark - Push Notification
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark - Other Application Delegates
// Overwrite setting in the Summary/Info.plist
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    DDLogVerbose(@"supportedInterfaceOrientationsForWindow");
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    DDLogVerbose(@"applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [GCAppViewModel saveAppDataToNSUserDefaults];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    DDLogVerbose(@"applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [GCAppViewModel saveAppDataToNSUserDefaults];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    DDLogVerbose(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [GCAppViewModel saveAppDataToNSUserDefaults];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    DDLogVerbose(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [GCAppViewModel getAppDataFromNSUserDefaultsAndUpdateViewModel];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    DDLogVerbose(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [GCAppViewModel saveAppDataToNSUserDefaults];
}

@end

// Add category to help UINavigationController to determine rotation
@implementation UINavigationController (OrientationSettings_IOS6)
-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}
@end
