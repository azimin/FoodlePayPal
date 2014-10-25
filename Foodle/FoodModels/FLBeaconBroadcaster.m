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

	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeIt) userInfo:nil repeats:YES];
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
	
}
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
		NSMutableDictionary *data = [[[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"] identifier:beaconID] peripheralDataWithMeasuredPower:nil];
		[self.pManager startAdvertising:data];
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
	
}
- (void)timeIt {
	
}
@end
