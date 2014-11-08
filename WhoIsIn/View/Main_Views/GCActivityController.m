//
//  GCActivityController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityController.h"
#import "GCActivityTableViewCell.h"

@implementation GCActivityController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize Variables

//    self.view.backgroundColor = [UIColor blueColor];
    
    // Activity Scroll View
    self.activityTableView = [[UITableView alloc] init];
    self.activityTableView.delegate = self;
    self.activityTableView.dataSource = self;
    [self.activityTableView registerClass:[GCActivityTableViewCell class] forCellReuseIdentifier: CellIdentifierForActivityTableViewCell];
    self.activityTableView.backgroundColor = [UIColor lightGrayColor];
    self.activityTableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.activityTableView];
    
    [self updateViewConstraints];
    
    // Fetch Activities
    [self fetchActivityDataWithParameter:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    DDLogInfo(@"viewWillAppear");
    // Navigation Control
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
    
    // Reload table view
    NSLog(@"reload..");
//    [self.surveyScrollView.orderTableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void)fetchActivityDataWithParameter:(NSDictionary *)parameter
{
    DDLogVerbose(@"fetchActivityDataWithParameter");
    if (!parameter) {
        // Fetch default activity list
        parameter = @{
                      @"method": @"getActivities",
                      @"sortBy": @"distance",
                      @"origin": @"35.749087,-78.885771",
                      @"showExpired": @"1",
                      };
        [GCAppViewModel getCurrentActivitiesWithParameter:parameter completion:^(BOOL succeeded) {
            if (succeeded) {
                [self.activityTableView reloadData];
            }
        }];
    }
}

- (void)updateViewConstraints
{
    DDLogVerbose(@"GCActivityController updateViewConstraints");
    [GCAppSetup setConstraints_FillFullScreenWithView:self.activityTableView superview:self.view];    
    
    [super updateViewConstraints];
}

#pragma mark - UITableView Delegate

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[GCAppViewModel sharedInstance].sortedActivities count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath...");
    GCActivityTableViewCell *cell = [self.activityTableView dequeueReusableCellWithIdentifier:CellIdentifierForActivityTableViewCell];
    [self configureCellContent:cell atRow:indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath");
    // Init a static instance of cell
    static GCActivityTableViewCell *cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.activityTableView dequeueReusableCellWithIdentifier: CellIdentifierForActivityTableViewCell];
    });
    [self configureCellContent:cell atRow:indexPath.row];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    // Set width of the tableview. Important for calculating multi-line & word-wraping UILabel. This happens automatically in cellForRowAtIndexPath
    cell.bounds = CGRectMake(0.0f, 0.0f, self.activityTableView.bounds.size.width, cell.bounds.size.height);
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    DDLogVerbose(@"cell height: %f", s.height + 1);
    return s.height + 1;
}

- (void)configureCellContent:(GCActivityTableViewCell *)cell atRow:(NSInteger)row
{
    GCActivity *activity = (GCActivity *)[GCAppViewModel sharedInstance].sortedActivities[row];
    DDLogVerbose(@"%@", activity);
    
    static NSDateFormatter *kDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kDateFormatter = [[NSDateFormatter alloc] init];
        kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        kDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";  // you configure this based on the strings that your webservice uses!!
    });

    cell.label_timeStart.text = [kDateFormatter stringFromDate:activity.timeStart];
    cell.label_distanceText.text = activity.distanceString;
    cell.label_title.text = activity.activityTitle;
    cell.label_description.text = activity.activityDescription;
    cell.label_location.text = activity.locationString;
    
}






@end
