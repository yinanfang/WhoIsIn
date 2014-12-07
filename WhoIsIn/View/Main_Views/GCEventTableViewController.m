//
//  GCEventTableViewController.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCEventTableViewController.h"
#import "GCEventTableViewCell.h"
#import "GCEventDetailViewController.h"

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
        self.hasSortBar = YES;
        
        // Configure table
        [self.tableView registerClass:[GCEventTableViewCell class] forCellReuseIdentifier: CellIdentifierForActivityTableViewCell];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [GCAppAPI getColorWithRGBAinHex:BackgroundWhiteShade];
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // Configure refresh control
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        self.refreshControl.tintColor = [UIColor whiteColor];
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.color = [UIColor clearColor];
        self.hud.activityIndicatorColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)updateViewConstraints
{
    DDLogVerbose(@"GCEventTableViewController updateViewConstraints");
    CGFloat topOffset = [GCAppAPI getSizeOfStatusbarAndNavigationBar:self.parentController].height;
    CGFloat sortBarHeight = [GCAppAPI getSizeOfNavigationBar:self.parentController].height;
    CGFloat bottomOffset = [GCAppAPI getHeightOfTabBar];
    DDLogVerbose(@"bottomOffset: %f", bottomOffset);
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.hasSortBar) {
            make.top.equalTo(self.parentController.view.mas_top).with.offset(topOffset+sortBarHeight);
            make.bottom.equalTo(self.parentController.view.mas_bottom).with.offset(-bottomOffset);
        } else {
            make.top.equalTo(self.parentController.view.mas_top);
            make.bottom.equalTo(self.parentController.view.mas_bottom);
        }
        make.left.equalTo(self.parentController.view.mas_left);
        make.right.equalTo(self.parentController.view.mas_right);
    }];
    [super updateViewConstraints];
}

- (void)reloadData
{
    // Stop and hide activity indicator in first load
    if (!self.hasLoadDataBefore) {
        [self.hud hide:YES];
        self.hasLoadDataBefore = YES;
    }
    
    // Reload table data
    DDLogVerbose(@"GCEventTableViewController reloadData with #%lu sorted Events", (unsigned long)[self.sortedEventsBasics count]);
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [[GCAppAPI dateFormatter02] stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        // Stop spinning
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - UITableView Delegate

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sortedEventsBasics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DDLogVerbose(@"cellForRowAtIndexPath...");
    GCEventTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierForActivityTableViewCell];
    [self configureCellContent:cell atRow:indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DDLogVerbose(@"heightForRowAtIndexPath");
    // Init a static instance of cell
    static GCEventTableViewCell *cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.tableView dequeueReusableCellWithIdentifier: CellIdentifierForActivityTableViewCell];
    });
    [self configureCellContent:cell atRow:indexPath.row];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    // Set width of the tableview. Important for calculating multi-line & word-wraping UILabel. This happens automatically in cellForRowAtIndexPath
    cell.bounds = CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, cell.bounds.size.height);
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
//    DDLogVerbose(@"cell height: %f", s.height + 1);
    return s.height + 1;
}

- (void)configureCellContent:(GCEventTableViewCell *)cell atRow:(NSInteger)row
{
    GCEventBasics *event = (GCEventBasics *)self.sortedEventsBasics[row];
//    DDLogVerbose(@"%@", event);
    cell.label_timeStart.text = [[GCAppAPI dateFormatter01] stringFromDate:event.timeToStart];
    cell.label_distanceText.text = event.distanceString;
    cell.label_title.text = event.eventTitle;
    cell.label_participantAndWatcher.text = [NSString stringWithFormat:@"%@ going, %@ watching", event.countParticipants, event.countWatch];
    cell.label_location.text = event.locationString;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLogVerbose(@"didSelectRowAtIndexPath");
    // Push Detail Activity View
    if (!_eventDetailViewController) {
        _eventDetailViewController = [[GCEventDetailViewController alloc] init];
    }
    [self.eventDetailViewController clearContentOfEventDetailViewController];
    // Start progress HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.eventDetailViewController.view animated:YES];
    hud.color = [GCAppAPI getColorWithRGBAinHex:BackgroundWhiteShade];
    hud.activityIndicatorColor = [UIColor grayColor];
    // Push blank controller and de-select row
    [self.navigationController pushViewController:self.eventDetailViewController animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Get GPS
    
    // Request event detail
    NSMutableDictionary *parameter = [@{
                                         @"method": @"getActivityDetail",
                                         @"idUser": [NSString stringWithFormat:@"%@", [GCAppViewModel sharedInstance].appData.currentUser.userID],
                                         @"idActivity": ((GCEventBasics *)self.sortedEventsBasics[indexPath.row]).eventID,
                                         @"origin": @"35.749087,-78.885771",
//                                        @"method": @"getActivityDetail",
//                                        @"idUser": @"1",
//                                        @"idActivity": @"2",
//                                        @"origin": @"35.749087,-78.885771",
                                         } mutableCopy];
    [GCAppViewModel getEventDetailWithParameter:parameter completion:^(BOOL succeeded) {
        if (succeeded) {
            // Re-configure eventDetailViewController
            [self.eventDetailViewController updateEventDetailViewController:[GCAppViewModel sharedInstance].eventDetail];
            [self.eventDetailViewController.detailScrollView setNeedsUpdateConstraints];
            [self.eventDetailViewController.detailScrollView updateConstraintsIfNeeded];
            // Hide progress HUD
            [hud hide:YES];
        } else {
            DDLogVerbose(@"Register fail. Need to enter again");
        }
    }];
    
//    self.eventDetailViewController.eventNumber = indexPath.row;

    // Set event detail and update constraints
    

}

@end
