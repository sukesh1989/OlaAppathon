//
//  HKLoginVC.h
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 07/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKHTTPRequestOperationManager.h"

@class HKMapVC;
@class HKAppDelegate;

@interface HKLoginVC : UIViewController<UITextFieldDelegate,HKHTTPRequestOperationManagerDelegate>
{
    IBOutlet UIActivityIndicatorView *activityIndicator;
}
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtpassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (nonatomic,strong) HKMapVC *objMapVC;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (nonatomic,strong) HKHTTPRequestOperationManager *objRequestMgr;
@property (nonatomic, strong) HKAppDelegate *sharedInstanceAppDelegate;


- (IBAction)btnLoginClicked:(id)sender;
- (IBAction) hideKeyboard:(id)sender;

@end
