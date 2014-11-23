//
//  GCRecycledCode.m
//  WhoIsIn
//
//  Created by Golden Compass on 11/7/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRecycledCode.h"

@implementation GCRecycledCode

@end



// Generate using Dictionary
//            NSDictionary *jsonDictionary = (NSDictionary *)data;
//            NSMutableArray *sortedActivities = [GCAppViewModel sharedInstance].sortedActivities;
//            NSInteger count = [jsonDictionary count];
//            NSString *countString;
//            DDLogVerbose(@"Generating %li new GCAvtivity object...", (long)count);
//            for (NSInteger i = 0; i < count; i++) {
//                countString = [NSString stringWithFormat:@"%li", (long)i];
//                GCActivity *activity = [MTLJSONAdapter modelOfClass:[GCActivity class] fromJSONDictionary:jsonDictionary[countString] error:&error];
//                if (error) {
//                    DDLogVerbose(@"Error generating GCActivity: %@", error);
//                } else {
//                    DDLogVerbose(@"activity item: %@", activity);
//                    [sortedActivities addObject:activity];
//                }
//            }
//            DDLogVerbose(@"sortedActivities value: %@", sortedActivities);
//            DDLogVerbose(@"sortedActivities count: %lu", (unsigned long)[sortedActivities count]);



/*
 >>>>>>>>>>>>>>>>>>>>>
    hide text field
 >>>>>>>>>>>>>>>>>>>>>
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 DDLogVerbose(@"GCRegisterViewController touchesBegan:withEvent:");
 UITouch *touch = [[event allTouches] anyObject];
 if ([self.registerView.entry_Email isFirstResponder] && [touch view] != self.registerView.entry_Email) {
 [self.registerView.entry_Email resignFirstResponder];
 [self.registerView.entry_Email.rac_textSignal
 //        [self moveDownContent];
 }
 if ([self.registerView.entry_Password isFirstResponder] && [touch view] != self.registerView.entry_Password) {
 [self.registerView.entry_Password resignFirstResponder];
 //        [self moveDownContent];
 }
 [super touchesBegan:touches withEvent:event];
 }

*/