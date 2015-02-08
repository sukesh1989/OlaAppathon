//
//  HKUserDetails.h
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 08/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKUserDetails : NSObject
@property (nonatomic,strong) NSString *strLatitude;
@property (nonatomic,strong) NSString *strLongitude;
@property (nonatomic,strong) NSString* strName;
@property (nonatomic,strong) NSString* strMobileNumber;
@property (nonatomic,strong) NSString* strAwayKm;
@property (nonatomic,strong) NSString* strCustCount;

@end
