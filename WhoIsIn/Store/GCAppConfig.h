//
//  GCAppConfig.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Theme Color hex with Pantone color
//PANTONE 19-4052 Classic Blue
#define ThemeColor01 0x1D4E89FF


// Don't change this
#pragma mark - CocoaLumberjack Logging Constant
#import <CocoaLumberjack/CocoaLumberjack.h>
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif
// Add a testing color for XcodeColors
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background
#define DDLogTest(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

@interface GCAppConfig : NSObject

#pragma mark - Domain
FOUNDATION_EXPORT NSString *const DevelopmentDomain;
FOUNDATION_EXPORT NSString *const ProductionDomain;

#pragma mark - Default Value
@property NSNumber *defaultStoryCount, *defaultBookCount;

#pragma mark - Book Specific
//@property NSInteger bookCurrentPageNumber;
@property CGRect PageControlRect, BookTitleViewRect;

#pragma mark - Story Specific
@property CGFloat WidthForSmallStory, HeightForSmallStory;
@property CGFloat WidthForCurrentStory, HeightForCurrentStory;
@property CGRect BoundsForStoryCollectionController;

#pragma mark - General
@property CGFloat PixelAdjustForHorizontalGap;
@property CGFloat HeightDeterminant_FloatVSFullScreen;
typedef NS_ENUM(NSInteger, DisplayStyleMode) {
    DisplayStyleModeFloat,
    DisplayStyleModeFullScreen,
};
//@property StoryDisplayStyleMode storyDisplayStyleMode;

@end
