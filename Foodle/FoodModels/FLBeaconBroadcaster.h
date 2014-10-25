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
#define TRANSFER_SERVICE_UUID           @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961"
#define TRANSFER_CHARACTERISTIC_UUID    @"08590F7E-DB05-467E-8757-72F6FAEB13D4"
#define kUseBeacons 1

@interface FLBeaconBroadcaster : NSObject <CBCentralManagerDelegate, CBPeripheralManagerDelegate>
- (void)broadCastBeacon;
@end
