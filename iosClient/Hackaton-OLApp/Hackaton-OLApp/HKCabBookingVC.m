//
//  HKCabBookingVC.m
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 07/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import "HKCabBookingVC.h"
#import "HKAppDelegate.h"

@interface HKCabBookingVC ()

@end

@implementation HKCabBookingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sharedInstanceAppDelegate = (HKAppDelegate*)[[UIApplication sharedApplication] delegate];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.lblCabAvailable.text = [NSString stringWithFormat:@"Dear %@, sharing cab is available and is %@ KM away from your location. Existing passenger count is %@.",self.sharedInstanceAppDelegate.objUserDetails.strName,self.sharedInstanceAppDelegate.objUserDetails.strAwayKm,self.sharedInstanceAppDelegate.objUserDetails.strCustCount];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [self.btnConfirmBooked setEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Network Callback
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didReceiveResponse:(id)response type:(NSString *)strType
{
//    if ([REQ_TYPE_GET_LATLNG isEqualToString: strType]) {
//        [self parseResponse:response];
//    }
//    else if([REQ_TYPE_GET_DIRECTIONS isEqualToString:strType])
//    {
//        [self parseResponseForDirections:response];
//    }
//    else if([REQ_TYPE_GETDRIVER isEqualToString:strType])
//    {
//        NSDictionary *dictResponse = (NSDictionary*) response;
//        self.sharedInstanceAppDelegate.objUserDetails.strAwayKm = [dictResponse valueForKey:@"awaykm"];
//        if (nil == self.objCabBookingVC) {
//            self.objCabBookingVC = [[HKCabBookingVC alloc] initWithNibName:@"HKCabBookingVC" bundle:[NSBundle mainBundle]];
//        }
//        [self.navigationController pushViewController:self.objCabBookingVC animated:YES];
//    }
}

-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didFailWithError:(NSError *)error
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We are sorry. No sharing cabs available for the selected source." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
//        [alert show];
//        
//    });
}

- (IBAction)btnConfirmClicked:(id)sender {
    self.lblCabAvailable.text = [NSString stringWithFormat:@"Dear %@, sharing cab has been confirmed.You will receive a SMS on the number %@ for further assistance.",self.sharedInstanceAppDelegate.objUserDetails.strName,self.sharedInstanceAppDelegate.objUserDetails.strMobileNumber];
    self.btnConfirmBooked.enabled = NO;
    
}
@end
