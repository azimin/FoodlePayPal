//
//  FLBeaconBroadcaster.m
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLBeaconBroadcaster.h"
#import <UIKit/UIKit.h>
@interface FLBeaconBroadcaster()
@property CBPeripheralManager *pManager;
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;
@end
@implementation FLBeaconBroadcaster

- (void)broadCastBeacon {
	self.pManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
	
}
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
	if (kUseBeacons) {
		NSMutableDictionary *data = [[[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:beaconUUID] major:70 identifier:beaconID] peripheralDataWithMeasuredPower:@1500];
		[self.pManager startAdvertising:data];
	} else {
		// Opt out from any other state
		if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
			return;
		}
		
		// We're in CBPeripheralManagerStatePoweredOn state...
		NSLog(@"self.peripheralManager powered on.");
		
		// ... so build our service.
		
		// Start with the CBMutableCharacteristic
		self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]
																																		 properties:CBCharacteristicPropertyNotify
																																					value:nil
																																		permissions:CBAttributePermissionsReadable];
		
		// Then the service
		CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
																																			 primary:YES];
		
		// Add the characteristic to the service
		transferService.characteristics = @[self.transferCharacteristic];
		
		// And add it to the peripheral manager
		[self.pManager addService:transferService];
		[self.pManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
	}
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
	[self sendData];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
	[self sendData];
}

- (void)sendData {
	// Copy out the data we want
	NSData *chunk = [NSData dataWithBytes:[@"DATADATA" dataUsingEncoding:NSUTF8StringEncoding].bytes length:[@"DATADATA" dataUsingEncoding:NSUTF8StringEncoding].length];
	
	// Send it
	BOOL didSend = [self.pManager updateValue:chunk forCharacteristic:self.transferCharacteristic onSubscribedCentrals:nil];
}

/** Recognise when the central unsubscribes
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
	NSLog(@"Central unsubscribed from characteristic");
}

@end
