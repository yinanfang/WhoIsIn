//
//  GCMyEventViewController.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCEventTableViewController.h"
#import "GCNewEventViewController.h"

@interface GCMyEventViewController : UIViewController

@property GCEventTableViewController *eventTableViewController;
@property GCNewEventViewController *addEventViewController;

@property BOOL hasLoadDataBefore;



@end
