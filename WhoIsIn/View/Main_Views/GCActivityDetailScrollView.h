//
//  GCActivityDetailScrollView.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCActivityDetailViewController;

@interface GCActivityDetailScrollView : UIScrollView

// Self
@property GCActivityDetailViewController *parentController;
@property BOOL didSetupConstraints;




#pragma mark - View Method
- (instancetype)initWithParentController:(GCActivityDetailViewController *)controller;
@end
