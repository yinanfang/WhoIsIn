//
//  GCEventDetailViewController.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCEventDetailScrollView.h"

@interface GCEventDetailViewController : UIViewController

// View
@property GCEventDetail *eventDetail;
@property GCEventDetailScrollView *detailScrollView;

@property MBProgressHUD *hud;


@end
