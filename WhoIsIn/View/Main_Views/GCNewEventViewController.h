//
//  GCNewEventViewController.h
//  WhoIsIn
//
//  Created by Golden Compass on 11/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCNewEventScrollView.h"

@interface GCNewEventViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property GCNewEventScrollView *eventScrollView;

@end
