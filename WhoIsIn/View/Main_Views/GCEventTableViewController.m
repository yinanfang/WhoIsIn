//
//  GCEventTableViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventTableViewController.h"

@implementation GCEventTableViewController

- (instancetype)initWithParentController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization Variables
        self.parentController = controller;
        self.view.backgroundColor = [UIColor lightGrayColor];

        // General Configuration
        self.eventSortMethod = EventSortedByDistance;
        
        // Configure table
        self.tableView.backgroundColor =[UIColor whiteColor];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // Configure refresh control
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [UIColor purpleColor];
        self.refreshControl.tintColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)updateViewConstraints
{
    DDLogVerbose(@"GCEventTableViewController updateViewConstraints");
    CGFloat topOffset = [GCAppAPI getSizeOfStatusbarAndNavigationBar:self.parentController].height;
    CGFloat sortBarHeight = [GCAppAPI getSizeOfNavigationBar:self.parentController].height;
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.parentController.view.mas_top).with.offset(topOffset+sortBarHeight);
        make.left.equalTo(self.parentController.view.mas_left);
        make.right.equalTo(self.parentController.view.mas_right);
        make.bottom.equalTo(self.parentController.view.mas_bottom);
    }];
    [super updateViewConstraints];
}

- (void)reloadData
{
    // Reload table data
    DDLogVerbose(@"GCEventTableViewController reloadData with #%lu sorted Events", (unsigned long)[self.sortedEvents count]);
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl updateConstraints];
        [self.refreshControl updateConstraintsIfNeeded];
        
        [self.refreshControl endRefreshing];

    }
}

#pragma mark - UITableView Delegate

#pragma mark - UITableView DataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [[GCAppViewModel sharedInstance].sortedEventsBasics count];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"cellForRowAtIndexPath...");
//    GCActivityTableViewCell *cell = [self.activityTableView dequeueReusableCellWithIdentifier:CellIdentifierForActivityTableViewCell];
//    [self configureCellContent:cell atRow:indexPath.row];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"heightForRowAtIndexPath");
//    // Init a static instance of cell
//    static GCActivityTableViewCell *cell;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        cell = [self.activityTableView dequeueReusableCellWithIdentifier: CellIdentifierForActivityTableViewCell];
//    });
//    [self configureCellContent:cell atRow:indexPath.row];
//    
//    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    // Set width of the tableview. Important for calculating multi-line & word-wraping UILabel. This happens automatically in cellForRowAtIndexPath
//    cell.bounds = CGRectMake(0.0f, 0.0f, self.activityTableView.bounds.size.width, cell.bounds.size.height);
//    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
//    
//    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
//    DDLogVerbose(@"cell height: %f", s.height + 1);
//    return s.height + 1;
//}
//
//- (void)configureCellContent:(GCActivityTableViewCell *)cell atRow:(NSInteger)row
//{
//    GCEvent *event = (GCEvent *)[GCAppViewModel sharedInstance].sortedEvents[row];
//    //    DDLogVerbose(@"%@", activity);
//    cell.label_timeStart.text = [[GCActivityController dateFormatter] stringFromDate:event.timeToStart];
//    cell.label_distanceText.text = event.distanceString;
//    cell.label_title.text = event.eventTitle;
//    cell.label_participantAndWatcher.text = [NSString stringWithFormat:@"%@ going, %@ watching", event.countParticipants, event.countWatch];
//    cell.label_location.text = event.locationString;
//    
//}
//
//+ (NSDateFormatter *)dateFormatter {
//    
//    static NSDateFormatter *kDateFormatter = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        kDateFormatter = [[NSDateFormatter alloc] init];
//        kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//        kDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";  // you configure this based on the strings that your webservice uses!!
//    });
//    return kDateFormatter;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DDLogVerbose(@"didSelectRowAtIndexPath");
//    // Push Detail Activity View
//    GCActivityDetailViewController *detailViewController = [[GCActivityDetailViewController alloc] init];
//    detailViewController.activityNumber = indexPath.row;
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    // De-select Row
//    [self.activityTableView deselectRowAtIndexPath:indexPath animated:YES];
//}

@end
