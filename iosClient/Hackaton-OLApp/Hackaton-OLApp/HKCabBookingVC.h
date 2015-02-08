//
//  HKCabBookingVC.h
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 07/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKHTTPRequestOperationManager.h"

@class HKAppDelegate;

@interface HKCabBookingVC : UIViewController<HKHTTPRequestOperationManagerDelegate>
- (IBAction)btnConfirmClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCabAvailable;
@property (nonatomic, strong) HKAppDelegate *sharedInstanceAppDelegate;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirmBooked;
@end
