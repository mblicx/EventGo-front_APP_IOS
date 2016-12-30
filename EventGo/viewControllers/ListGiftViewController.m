//
//  ListGiftViewController.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 14/04/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import "ListGiftViewController.h"
#import "locationUpdateManager.h"
#import "constants.h"

@implementation ListGiftViewController


- (void) viewWillAppear:(BOOL)animated {

    if ([[locationUpdateManager sharedStandardManager] isScanning]) {
        
        _view_topBar.backgroundColor = [UIColor colorWithRed:Yellow_red green:Yellow_green blue:Yellow_blue alpha:1.0];
    }
    else {
        _view_topBar.backgroundColor = [UIColor colorWithRed:Green_red green:Green_green blue:Green_blue alpha:1.0];
        
    }
}
- (IBAction)reset:(id)sender {
//    [[[UcheckinManager sharedManager] arrayOfCodesUnshow] removeAllObjects];
//    [[[UcheckinManager sharedManager] arrayOfCodesNotified] removeAllObjects];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifiedGain" object:nil];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[[UcheckinManager sharedManager] arrayOfCodesUnshow] forKey:@"arrayOfCodesUnshow"];
//    [[NSUserDefaults standardUserDefaults] setObject:[[UcheckinManager sharedManager] arrayOfCodesUnshow] forKey:@"arrayOfCodesNotified"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
