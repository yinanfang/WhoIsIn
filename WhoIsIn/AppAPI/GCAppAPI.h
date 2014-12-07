//
//  GCAppAPI.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// AFNetworking
#import <AFNetworking.h>
// CocoaLumberjack
#import <CocoaLumberjack/DDLog.h>
#import <DDTTYLogger.h>
#import <DDASLLogger.h>
#import <DDFileLogger.h>
#import "GCCustomLogFormatters.h"
// facebook-ios-sdk
#import <FacebookSDK/FacebookSDK.h>
// FlatUIKit
#import <FlatUIKit/FlatUIKit.h>
// LBBlurredImage
#import <FXBlurView/FXBlurView.h>
// JSQMessagesViewController
#import <JSQMessagesViewController/JSQMessages.h>
// JVFloatLabeledTextView.h
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <JVFloatLabeledTextField/JVFloatLabeledTextView.h>
// Mantle
#import <Mantle/Mantle.h>
// Masonry
#import <Masonry.h>
// MBProgressHUD
#import "MBProgressHUD.h"
// TSMessage
#import <TSMessages/TSMessage.h>
// POP
#import <pop/POP.h>
// ReactiveCocoa
#import <ReactiveCocoa/ReactiveCocoa.h>
// Shimmer
#import <Shimmer/FBShimmeringView.h>
// Tweaks
#import <Tweaks/FBTweak.h>

// Data Model
#import "GCEventBasics.h"
#import "GCEventDetail.h"
#import "GCUser.h"
#import "GCAppData.h"

// View Model
#import "GCAppViewModel.h"

// App Import
#import "GCAppSetup.h"
#import "GCAppConfig.h"
#import "GCConstant.h"
#import "GCNetwork.h"
#import "GCLocation.h"


@interface GCAppAPI : NSObject

// Accessor for Singleton class
+ (GCAppAPI *)sharedInstance;

#pragma mark - Basic Utilities
+ (NSString *)getCurrentDomain;
+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color;
+ (void)setHasShownTour:(BOOL)mode;
+ (BOOL)didRunAppBefore;
+ (UIImageView *)getFullScreenImageView:(NSString *)name;
+ (NSString *)getMD5StringWithString:(NSString *)string;
+ (UIView *)getFirstResponderFromView:(UIView *)view;
+ (void)shakeViewArray:(NSArray *)viewArray;
+ (void)shakeViewArray:(NSArray *)viewArray withDuration:(NSTimeInterval)duration completion:(void (^)())completion;

#pragma mark - Size & Rect
+ (CGSize)getSizeOfStatusbar:(UIViewController *)controller;
+ (CGSize)getSizeOfNavigationBar:(UIViewController *)controller;
+ (CGSize)getSizeOfStatusbarAndNavigationBar:(UIViewController *)controller;
+ (CGRect)getScreenBoundsDependOnOrientation;
+ (CGFloat)getHeightOfTabBar;
//+ (CGSize)getSizeOfTabBar:(UIViewController *)tabBarController;
//+ (CGRect)getBoundsOfTabBar:(UIViewController *)tabBarController;

#pragma mark - Mantle
+ (id)getMantleModelWithDictionary:(NSDictionary *)dictionary modelClass:(Class)modelClass;

#pragma mark - Date Formatter
+ (NSDateFormatter *)dateFormatter01;
+ (NSDateFormatter *)dateFormatter02;
+ (NSDateFormatter *)dateFormatter03;
+ (NSDateFormatter *)dateFormatter04;













@end