//
//  HKAppDelegate.h
//  Hackaton-OLApp
//
//  Created by Rajiv Venkatesh on 06/02/15.
//  Copyright (c) 2015 raj.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKMapVC;

@interface HKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,strong) HKMapVC *objMapVC;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
