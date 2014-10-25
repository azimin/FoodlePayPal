//
//  AppDelegate.h
//  FoodModels
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLPaymentsManager.h"
#import "FLBeaconsMonitor.h"
#define kbroadCastBeacon 1

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property FLPaymentsManager *paymentsManager;
@property FLBeaconsMonitor *monitor;
+ (AppDelegate *)sharedAppDelegate;

@end

