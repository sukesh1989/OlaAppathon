//
//  HKMapVC.m
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 06/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import "HKMapVC.h"
#import "HKCabBookingVC.h"
#import "Constants.h"
#import "HKAppDelegate.h"

#define TAG_SEARCHBAR_SOURCE 112
#define TAG_SEARCHBAR_DESTINATION 113

@interface HKMapVC ()

@end

@implementation HKMapVC{
    GMSMapView *mapView_;
}

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
    
    self.objRequestMgr = [HKHTTPRequestOperationManager sharedInstance];

    
    self.btnPickMe.enabled = NO;
    originLat = [self.sharedInstanceAppDelegate.objUserDetails.strLatitude doubleValue];
    originLng = [self.sharedInstanceAppDelegate.objUserDetails.strLongitude doubleValue];
    [self makeANetworkCall];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:originLat
                                                            longitude:originLng
                                                                 zoom:10];
    mapView_ = [GMSMapView mapWithFrame:self.ViewContainer.frame camera:camera];
    mapView_.myLocationEnabled = NO;
    [self.ViewContainer addSubview:mapView_];
    
    searchBarFrom = [[UISearchBar alloc]initWithFrame:CGRectZero];
    searchBarFrom.delegate = self;
    searchBarFrom.frame = CGRectMake(0, 20, 320, 30);
    searchBarFrom.placeholder = @"Source";
    searchBarFrom.translucent = YES;
    searchBarFrom.alpha = 0.97;
    searchBarFrom.tag = TAG_SEARCHBAR_SOURCE;
    [self.ViewContainer addSubview:searchBarFrom];
    
    searchBarTo = [[UISearchBar alloc]initWithFrame:CGRectZero];
    searchBarTo.delegate = self;
    searchBarTo.frame = CGRectMake(0, 50, 320, 30);
    searchBarTo.placeholder = @"Destination";
    searchBarTo.translucent = YES;
    searchBarTo.alpha = 0.97;
    searchBarTo.tag = TAG_SEARCHBAR_DESTINATION;
    [self.ViewContainer addSubview:searchBarTo];

    // Creates a marker in the center of the map.
    markerStart = [[GMSMarker alloc] init];
    markerStart.position = CLLocationCoordinate2DMake(originLat, originLng);
    markerStart.title = @"Start";
    markerStart.map = mapView_;
    
    mapView_.accessibilityElementsHidden = NO;
    mapView_.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void) makeANetworkCall
{
    [self.objRequestMgr setDelegate:self];
    NSDictionary *dictParamaters = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%f,%f",originLat,originLng],@"latlng", nil];
    [self.objRequestMgr getData:dictParamaters type:REQ_TYPE_GET_LATLNG];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Callback
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didReceiveResponse:(id)response type:(NSString *)strType
{
    if ([REQ_TYPE_GET_LATLNG isEqualToString: strType]) {
        [self parseResponse:response];
    }
    else if([REQ_TYPE_GET_DIRECTIONS isEqualToString:strType])
    {
        [self parseResponseForDirections:response];
    }
    else if([REQ_TYPE_GETDRIVER isEqualToString:strType])
    {
        NSDictionary *dictResponse = (NSDictionary*) response;
        self.sharedInstanceAppDelegate.objUserDetails.strAwayKm = [dictResponse valueForKey:@"awaykm"];
        self.sharedInstanceAppDelegate.objUserDetails.strCustCount = [[dictResponse valueForKey:@"car"] valueForKey:@"seatsoccupied"];
        if (nil == self.objCabBookingVC) {
            self.objCabBookingVC = [[HKCabBookingVC alloc] initWithNibName:@"HKCabBookingVC" bundle:[NSBundle mainBundle]];
        }
        [self.navigationController pushViewController:self.objCabBookingVC animated:YES];
    }
}

-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didFailWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We are sorry. No sharing cabs available for the selected source." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];

    });
}

#pragma mark - Parsing Code

-(void) parseResponse:(id)response
{
    NSDictionary *dictResponse = (NSDictionary*)response;
    
    if (YES == self.btnPickMe.enabled) {
        NSDictionary *dictCoordinates = [[[[dictResponse valueForKey:@"results"] objectAtIndex:0] valueForKey:@"geometry"] valueForKey:@"location"];
        destLat = [[dictCoordinates valueForKey:@"lat"] doubleValue];
        destLng = [[dictCoordinates valueForKey:@"lng"] doubleValue];
        [self addMarker];
    }
    else
    {
        NSString *strCoordinates = [[[dictResponse valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"];
        dispatch_async(dispatch_get_main_queue(), ^{
            searchBarFrom.text = strCoordinates;
        });
    }
}

-(void) parseResponseForDirections:(id)response
{
    NSLog(@"directions response");
    NSDictionary *dictResponse = (NSDictionary*) response;
    if ([[dictResponse valueForKey:@"status"] isEqualToString:@"ZERO_RESULTS"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Sorry, no routes available." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        NSDictionary *routes = dictResponse[@"routes"][0];
        NSDictionary *route = routes[@"overview_polyline"];
        NSString *overview_route = route[@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
        for (int i=0; i<path.count; i++) {
            NSLog(@"coordinates are %f, %f",[path coordinateAtIndex:i].latitude,[path coordinateAtIndex:i].longitude);
        }
        polyline = [GMSPolyline polylineWithPath:path];
        polyline.map = mapView_;
    }
}

-(void) addMarker
{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(destLat, destLng);
    markerEnd = [GMSMarker markerWithPosition:position];
    markerEnd.title = @"Destination";
    markerEnd.map = mapView_;

    GMSCameraPosition *destination = [GMSCameraPosition cameraWithLatitude:destLat
                                                            longitude:destLng
                                                                 zoom:10];
    [mapView_ setCamera:destination];
    
    [self getDirections];
}

-(void) getDirections
{
    NSDictionary *dictParamaters = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%f,%f",originLat,originLng],@"origin",[NSString stringWithFormat:@"%f,%f",destLat,destLng],@"destination", nil];
    [self.objRequestMgr getData:dictParamaters type:REQ_TYPE_GET_DIRECTIONS];
}

- (IBAction)btnPickMeClicked:(id)sender {
    NSDictionary *dictParamaters = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%f",originLat],@"fromlat",[NSString stringWithFormat:@"%f",originLng],@"fromlong",[NSString stringWithFormat:@"%f",destLat],@"tolat",[NSString stringWithFormat:@"%f",destLat],@"tolong", nil];
    [self.objRequestMgr getDataFromCustomServer:dictParamaters type:REQ_TYPE_GETDRIVER];
}

#pragma mark - UISearchFieldDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                   // called when keyboard search button pressed
{
    if (TAG_SEARCHBAR_SOURCE == searchBar.tag) {
        //
    }
    else if(TAG_SEARCHBAR_DESTINATION == searchBar.tag)
    {
        NSDictionary *dictParamaters = [[NSDictionary alloc] initWithObjectsAndKeys:searchBar.text,@"address", nil];
        [self.objRequestMgr getData:dictParamaters type:REQ_TYPE_GET_LATLNG];
    }
    [searchBarFrom resignFirstResponder];
    [searchBarTo resignFirstResponder];
    self.btnPickMe.enabled = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (nil == searchText || [searchText isEqualToString:@""]) {
        polyline.map = nil;
        markerEnd.map = nil;
        self.btnPickMe.enabled = NO;
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 111) {
        //NSLog(@"ended");
    }
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
   // NSLog(@"editing began");
}

#pragma mark - MapView Delegate
- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [searchBarFrom resignFirstResponder];
    [searchBarTo resignFirstResponder];
}

@end
