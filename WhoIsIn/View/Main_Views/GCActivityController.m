//
//  GCActivityController.m
//  WhoIsIn
//
//  Created by Golden Compass on 10/26/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCActivityController.h"

@implementation GCActivityController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize Variables
    self.view.backgroundColor = [UIColor blueColor];
    
    // Activity Scroll View
    self.activitScrollView = [UITableView new];
    self.activitScrollView.delegate = self;
    self.activitScrollView.backgroundColor = [UIColor lightGrayColor];
    self.activitScrollView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.activitScrollView];
    [self updateViewConstraints];

    // Fetch Activities
    [self fetchActivityDataWithParameter:nil];
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
        BOOL shouldReloadTable = [GCAppViewModel getCurrentActivitiesWithParameter:parameter];
        if (shouldReloadTable) {
            DDLogVerbose(@"shouldReloadTable");
            [self.activitScrollView reloadData];
        }
    }
}

- (void)updateViewConstraints
{
    DDLogVerbose(@"GCActivityController updateViewConstraints");
    [GCAppSetup setConstraints_FillFullScreenWithView:self.activitScrollView superview:self.view];
    
    [super updateViewConstraints];
}

#pragma mark - UITableView Delegate

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [[GCAppViewModel sharedInstance].currentUnsavedOrders count];
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"cellForRowAtIndexPath...");
//    DDLogWarn(@"%li", (long)indexPath.row);
//    GCOrderTableViewCell *cell = [self.surveyScrollView.orderTableView dequeueReusableCellWithIdentifier:CellIdentifierForOrderTableViewCell];
//    [self configureCellContent:cell atRow:indexPath.row];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    return cell;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"heightForRowAtIndexPath");
    // Init a static instance of cell
//    static GCOrderTableViewCell *cell;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        cell = [self.surveyScrollView.orderTableView dequeueReusableCellWithIdentifier: CellIdentifierForOrderTableViewCell];
//    });
//    [self configureCellContent:cell atRow:indexPath.row];
//    
//    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    // Set width of the tableview. Important for calculating multi-line & word-wraping UILabel. This happens automatically in cellForRowAtIndexPath
//    cell.bounds = CGRectMake(0.0f, 0.0f, self.surveyScrollView.orderTableView.bounds.size.width, cell.bounds.size.height);
//    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
//    
//    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
//    DDLogVerbose(@"cell height: %f", s.height + 1);
//    return s.height + 1;
//}

//- (void)configureCellContent:(GCOrderTableViewCell *)cell atRow:(NSInteger)row
//{
//    //    DDLogVerbose(@"hit add button at index: %li", (long)[self.surveyScrollView.orderTableView indexPathForCell:cell].row);
//    DDLogWarn(@"cell tag: %li", (long)cell.tag);
//    
//    GCOrder *order = (GCOrder *)[GCAppViewModel sharedInstance].currentUnsavedOrders[row];
//    DDLogVerbose(@"%@", order);
//    cell.label_OrderName.text = order.orderName;
//    cell.label_Length.text = [NSString stringWithFormat:@"Length: %@", order.length];
//    cell.label_Count.text = [NSString stringWithFormat:@"Count: %@", order.count];
//    cell.label_Notes.text = [NSString stringWithFormat:@"Notes: %@", order.note];
//    UIImage *image = [UIImage imageWithContentsOfFile:order.orderPhotoLocalURL];
//    cell.captureImageView.image = image;
//    
//    cell.btn_Add.tag = row;
//    [cell.btn_Add addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
//    cell.btn_Minus.tag = row;
//    [cell.btn_Minus addTarget:self action:@selector(minusCount:) forControlEvents:UIControlEventTouchUpInside];
//    
//}






@end
