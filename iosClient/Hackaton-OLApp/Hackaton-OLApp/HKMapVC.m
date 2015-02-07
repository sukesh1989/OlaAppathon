//
//  HKMapVC.m
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 06/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import "HKMapVC.h"
#import <GoogleMaps/GoogleMaps.h>
@interface HKMapVC ()

@end

@implementation HKMapVC{
    GMSMapView *mapView_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self makeANetworkCall];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    
    mapView_.myLocationEnabled = YES;
    mapView_.accessibilityElementsHidden = NO;
    // Do any additional setup after loading the view from its nib.
}

-(void) makeANetworkCall
{
    self.objRequestMgr = [HKHTTPRequestOperationManager sharedInstance];
    [self.objRequestMgr setDelegate:self];
    [self.objRequestMgr getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Callback
-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didReceiveResponse:(id)response
{
    
}

-(void)HKHTTPRequestOperationManager:(HKHTTPRequestOperationManager *)client didFailWithError:(NSError *)error
{
    
}


@end
