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