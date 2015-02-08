//
//  HKLoginVC.m
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 07/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import "HKLoginVC.h"
#import "HKMapVC.h"
#import "Constants.h"
#import "HKAppDelegate.h"

@interface HKLoginVC ()

@end

@implementation HKLoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sharedInstanceAppDelegate = (HKAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.sharedInstanceAppDelegate.objUserDetails =[HKUserDetails new];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [activityIndicator setHidden:YES];
    self.objRequestMgr = [HKHTTPRequestOperationManager sharedInstance];
    self.objRequestMgr.delegate = self;
    _txtUsername.delegate = self;
    _txtpassword.delegate = self;
    if ([_txtUsername respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _txtUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
        _txtpassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];

    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginClicked:(id)sender {
    [self hideKeyboard:nil];
    [self setEnableControls:NO];
    if ([self validateInput]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
        dispatch_async(queue, ^{
            NSDictionary *dictParamaters = [[NSDictionary alloc] initWithObjectsAndKeys:self.txtUsername.text,@"email", nil];
            [self.objRequestMgr getDataFromCustomServer:dictParamaters type:REQ_TYPE_AUTHENTICATE];
        });
    }
}

#pragma mark - Network Callback
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didReceiveResponse:(id)response type:(NSString *)strType
{
    [self parseLoginResponse:response];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setEnableControls:YES];
        self.objMapVC = [[HKMapVC alloc] initWithNibName:@"HKMapVC" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:self.objMapVC animated:YES];

    });
}

-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didFailWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setEnableControls:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Username and/or password" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    });
}

-(BOOL) validateInput
{
    if ([_txtUsername.text isEqualToString:@""] && [_txtpassword.text isEqualToString:@""]) {
        _lblError.text = @"Username/Password can't be empty";
        _lblError.hidden = NO;
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}

-(void) parseLoginResponse:(id)response
{
    NSDictionary *dictResponse = (NSDictionary*) response;
    if ([response valueForKey:@"name"] != nil) {
        self.sharedInstanceAppDelegate.objUserDetails.strName = [dictResponse valueForKey:@"name"];
    }
    self.sharedInstanceAppDelegate.objUserDetails.strMobileNumber = [dictResponse valueForKey:@"mobile"];
    self.sharedInstanceAppDelegate.objUserDetails.strLatitude = [dictResponse valueForKey:@"defaultlat"];
    self.sharedInstanceAppDelegate.objUserDetails.strLongitude = [dictResponse valueForKey:@"defaultlong"];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _lblError.hidden = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_txtUsername resignFirstResponder];
    [_txtpassword resignFirstResponder];
}

- (void)setEnableControls:(BOOL)bEnabled
{
    if (bEnabled)
    {
        [activityIndicator stopAnimating];
        [activityIndicator setHidden:YES];
    }
    else
    {
        [activityIndicator startAnimating];
        [activityIndicator setHidden:NO];
    }
    
    [_txtUsername setEnabled:bEnabled];
    [_txtpassword setEnabled:bEnabled];
    [_btnLogin setEnabled:bEnabled];
}

- (IBAction) hideKeyboard:(id)sender
{
    [_txtUsername endEditing:NO];
    [_txtpassword endEditing:NO];
}
@end
