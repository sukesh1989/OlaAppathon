//
//  HKMapVC.h
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 06/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKHTTPRequestOperationManager.h"
#import <GoogleMaps/GoogleMaps.h>
#import "HKUserDetails.h"

@class HKCabBookingVC;
@class HKAppDelegate;

@interface HKMapVC : UIViewController<HKHTTPRequestOperationManagerDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UITextFieldDelegate,GMSMapViewDelegate>
{
    double originLat;
    double originLng;
    double destLat;
    double destLng;

    UISearchBar *searchBarFrom;
    UISearchBar *searchBarTo;
    
    GMSMarker *markerStart;
    GMSMarker *markerEnd;
    GMSPolyline *polyline;
}

@property (nonatomic,strong) HKHTTPRequestOperationManager *objRequestMgr;
@property (weak, nonatomic) IBOutlet UIView *ViewContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnPickMe;
@property (nonatomic, strong) HKCabBookingVC *objCabBookingVC;
@property (nonatomic,strong) HKUserDetails *objUserDetails;
@property (nonatomic, strong) HKAppDelegate *sharedInstanceAppDelegate;

- (IBAction)btnPickMeClicked:(id)sender;

@end
