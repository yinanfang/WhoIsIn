//
//  GCAllEventViewController.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSortControlViewController.h"
#import "GCEventTableViewController.h"

@interface GCAllEventViewController : UIViewController <CLLocationManagerDelegate>

@property GCSortControlViewController *sortController;
@property GCEventTableViewController *eventTableViewController;

@property BOOL hasLoadDataBefore;

@property CLLocationManager *locationManager;
@end
