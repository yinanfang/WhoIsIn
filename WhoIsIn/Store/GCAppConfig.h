//
//  GCAppConfig.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Theme Color hex with Pantone color

// Theme Color
#define ThemeColor01                0x1D4E89FF  // PANTONE 19-4052 Classic Blue
#define ThemeColor01_Variation01    0x567DABFF  // More black. Go down
#define ThemeColor01_Variation02    0x376296FF  // More black. Go down
#define ThemeColor01_Variation03    0x113B6EFF  // More black. Go down
#define ThemeColor01_Variation04    0x062954FF  // More black. Go down

#define WhiteFading                 0xFFFFFF45  //
#define BackgroundWhiteShade        0xF1F1F1FF  

// Font and Size
#define Font_Logo                   @"Chalkduster"
#define Font_Title                  @"AppleGothic"
#define Font_Paragraph              @"AppleGothic"
#define FontTheme01                 @"Helvetica"
#define FontTheme01_Bold            @"Helvetica-Bold"

#define FontSize_LogInTextField     22.0f
#define FontSize_H1                 18.0f
#define FontSize_H2                 16.0f
#define FontSize_P1                 16.0f
#define WidthForEntryfieldBorder    1.0f
#define CornerRadius_General        10.0f

// Animation
#define kAnimationDuration_Short     0.25
#define kAnimationDelay_Short        0.25
#define kAnimationDelay_None         0


// General Layout Metrics
// For MASConstraintMaker
#define mas_Padding_Page_Large          UIEdgeInsetsMake(20, 20, -20, -20)
#define mas_Padding_Page_Small          UIEdgeInsetsMake(5, 5, -5, -5)
#define mas_Padding_Page_Default        UIEdgeInsetsMake(8, 8, -8, -8)
// For UIKit
#define Insets_Default              UIEdgeInsetsMake(8, 8, 8, 8)
#define Insets_Button               UIEdgeInsetsMake(8, 10, 8, 10)

// Table View Configuration
#define CellIdentifierForActivityTableViewCell      @"ActivityTableViewCellIdentifier"

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
FOUNDATION_EXPORT NSString *const URIToServicePHP;
FOUNDATION_EXPORT NSString *const URLToServicePHP;

#pragma mark - NSUserDefaults values
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForDidShownTour;
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForDidRunAppBefore;
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForAppData;

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
typedef NS_ENUM(NSInteger, PagePaddingOption) {
    PagePaddingSmall,
    PagePaddingLarge,
};
//@property StoryDisplayStyleMode storyDisplayStyleMode;

#pragma mark - Events ENUM
typedef NS_ENUM(NSInteger, GCEventSortMethod) {
    EventSortedByDistance,
    EventSortedByAllTime,
    EventSortedByUpComing,
};

typedef NS_ENUM(NSInteger, GCStateLoadingData) {
    LoadingInProgress,
    LoadingFinished,
};
@end
