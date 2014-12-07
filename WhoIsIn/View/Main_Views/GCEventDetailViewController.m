//
//  GCEventDetailViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/22/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventDetailViewController.h"

@implementation GCEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Activity Detail"];
    
    // Add Activity Detail Scroll View
    self.detailScrollView = [[GCEventDetailScrollView alloc] initWithParentController:self];
    [self.detailScrollView setNeedsUpdateConstraints];
    [self.detailScrollView updateConstraintsIfNeeded];
    
    [[self.detailScrollView.btn_join rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Join button tapped");

    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"GCActivity Detail View Controller touchesBegan:withEvent:");
    [super touchesBegan:touches withEvent:event];
}

- (void)clearContentOfEventDetailViewController
{
    GCEventDetailScrollView *detailView = self.detailScrollView;
    detailView.label_title.text = @"        ";
    detailView.label_host.text = @"        ";
    detailView.label_timeStart.text = @"        ";
    detailView.label_location.text = @"        ";
    detailView.label_distanceText.text = @"        ";
    detailView.textviewDescription.text = @"                                                                                                                                                                  ";
    [detailView.mapView setRegion:[GCLocation getRegionWithDefaultValue] animated:NO];
}

- (void)updateEventDetailViewController:(GCEventDetail *)event
{
    // update EventDetail
    self.eventDetail = event;
    // update content
    GCEventDetailScrollView *detailView = self.detailScrollView;
    detailView.label_title.text = event.eventTitle;
    detailView.label_host.text = [NSString stringWithFormat:@"Hosted by %@ %@", event.nameFirst, event.nameLast];
    detailView.label_timeStart.text = [[GCAppAPI dateFormatter02] stringFromDate:event.timeToStart];
    detailView.label_location.text = event.locationString;
    detailView.label_distanceText.text = event.distanceString;
    detailView.textviewDescription.text = event.eventDescription;
    [detailView.textviewDescription mas_updateConstraints:^(MASConstraintMaker *make) {
        CGSize sizeFit = [detailView.textviewDescription sizeThatFits:CGSizeMake([detailView getTextViewDescriptionAdjustedWidth] , MAXFLOAT)];
        make.height.mas_equalTo(sizeFit.height);
    }];
    [detailView.mapView setRegion:[GCLocation getRegionWithLatitude:[event.latitude doubleValue] longitude:[event.longitude doubleValue]] animated:YES];
    // Add annotation
}

@end
