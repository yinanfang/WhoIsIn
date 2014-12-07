//
//  GCMessageViewController.h
//  WhoIsIn
//
//  Created by Golden Compass on 12/6/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSUserDefaults+DemoSettings.h"
#import "GCMessageViewModel.h"

@class DemoMessagesViewController;

@protocol JSQDemoViewControllerDelegate <NSObject>

- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc;

@end




@interface GCMessageViewController : JSQMessagesViewController <UIActionSheetDelegate>

@property (weak, nonatomic) id<JSQDemoViewControllerDelegate> delegateModal;

@property (strong, nonatomic) GCMessageViewModel *demoData;

- (void)receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)closePressed:(UIBarButtonItem *)sender;

@end
