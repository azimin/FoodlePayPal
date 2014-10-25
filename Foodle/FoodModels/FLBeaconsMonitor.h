//
//  FLBeaconsMonitor.h
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface FLBeaconsMonitor : NSObject <CLLocationManagerDelegate, CBPeripheralManagerDelegate, CBCentralManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CBCentralManager      *centralManager;
@property (strong, nonatomic) CBPeripheral          *discoveredPeripheral;

@end
