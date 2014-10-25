//
//  FLBeaconBroadcaster.m
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLBeaconBroadcaster.h"
@interface FLBeaconBroadcaster()
@property CBPeripheralManager *pManager;
@end
@implementation FLBeaconBroadcaster

- (void)broadCastBeacon {
	self.pManager = 	[[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
	
}
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
		NSMutableDictionary *data = [[[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:beaconUUID] identifier:beaconID] peripheralDataWithMeasuredPower:nil];
		[self.pManager startAdvertising:data];
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
	
}
- (void)timeIt {
	
}
@end
