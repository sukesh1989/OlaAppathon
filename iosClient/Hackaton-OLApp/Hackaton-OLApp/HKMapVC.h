//
//  HKMapVC.h
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 06/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKHTTPRequestOperationManager.h"

@interface HKMapVC : UIViewController<HKHTTPRequestOperationManagerDelegate>

@property (nonatomic,strong) HKHTTPRequestOperationManager *objRequestMgr;

@end
