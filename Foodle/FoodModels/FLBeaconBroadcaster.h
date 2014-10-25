//
//  FLBeaconBroadcaster.h
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#define beaconUUID @"EBEFD083-70A2-47C8-9837-E7B5634DF524"
#define beaconID @"com.foodler"

@interface FLBeaconBroadcaster : NSObject <CBCentralManagerDelegate, CBPeripheralManagerDelegate>
- (void)broadCastBeacon;
@end
