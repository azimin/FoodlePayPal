//
//  FLBeaconsMonitor.m
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLBeaconsMonitor.h"
#import "FLBeaconBroadcaster.h"
#import "FLRestaurantsRequestManager.h"

@implementation FLBeaconsMonitor

- (instancetype)init {
	if (self = [super init]) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		if (kUseBeacons) {
			[self initRegion];
			[[FLRestaurantsRequestManager sharedInstance] getRestaurantsCompletion:nil];
		} else {
			self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
		}
	}
	return self;
}

- (void)initRegion {
	NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:beaconUUID];
	self.beaconRegion =  [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:beaconID];
	
	self.beaconRegion.notifyEntryStateOnDisplay = YES;
	self.beaconRegion.notifyOnEntry = YES;
	self.beaconRegion.notifyOnExit = YES;
	[self.locationManager requestAlwaysAuthorization];
	[self.locationManager startMonitoringForRegion:self.beaconRegion];
	[self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status	 {
	
}
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
	NSLog(@"monitoringDidFailForRegion - error: %@", [error localizedDescription]);
}
- (void)locationManager:(CLLocationManager *)manager
			 didFailWithError:(NSError *)error {
	NSLog(@"monitoringDidFailForRegion - error: %@", [error localizedDescription]);
}
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
	
}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
	[self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
	[[FLRestaurantsRequestManager sharedInstance] getRestaurantsWithBeaconId:self.beaconRegion.major completion:nil];
	NSLog(@"OH YES");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
	[self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
	NSLog(@"OH NO");
}
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
	if (state == CLRegionStateInside) {
	//Notif
	}
}
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
	CLBeacon *beacon = [[CLBeacon alloc] init];
	beacon = [beacons lastObject];
	
	NSLog(@"UUIDString %@ MAJOR %@ MINOR %@", beacon.proximityUUID.UUIDString, beacon.major, beacon.minor);
	if (beacon.proximity == CLProximityUnknown) {
		NSLog(@"Unknown Proximity");
	} else if (beacon.proximity == CLProximityImmediate) {
		[[FLRestaurantsRequestManager sharedInstance] getRestaurantsWithBeaconId:beacon.major completion:nil];
		NSLog(@"Immediate");
	} else if (beacon.proximity == CLProximityNear) {
		[[FLRestaurantsRequestManager sharedInstance] getRestaurantsWithBeaconId:beacon.major completion:nil];
		NSLog(@"Near");
	} else if (beacon.proximity == CLProximityFar) {
		[[FLRestaurantsRequestManager sharedInstance] getRestaurantsWithBeaconId:beacon.major completion:nil];
		NSLog(@"FAR");
	}
	
}
- (BOOL)isARestaurantRegion:(CLBeaconRegion *)region {
	if ([region.proximityUUID.UUIDString isEqualToString:beaconUUID]) {
		return YES;
	}
	return YES;
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
	if (central.state != CBCentralManagerStatePoweredOn) {
		return;
	}
	
	[self scan];
	
}


/** Scan for peripherals - specifically for our service's 128bit CBUUID
 */
- (void)scan
{
	[self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
																							options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
	
	NSLog(@"Scanning started");
}


/** This callback comes whenever a peripheral that is advertising the TRANSFER_SERVICE_UUID is discovered.
 *  We check the RSSI, to make sure it's close enough that we're interested in it, and if it is,
 *  we start the connection process
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
	// Reject any where the value is above reasonable range
	if (RSSI.integerValue > -15) {
		return;
	}
	
	// Reject if the signal strength is too low to be close enough (Close is around -22dB)
	if (RSSI.integerValue < -35) {
		return;
	}
	
	NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
	
	// Ok, it's in range - have we already seen it?
	if (self.discoveredPeripheral != peripheral) {
		
		// Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
		self.discoveredPeripheral = peripheral;
		
		// And connect
		NSLog(@"Connecting to peripheral %@", peripheral);
		[self.centralManager connectPeripheral:peripheral options:nil];
	}
}


/** If the connection fails for whatever reason, we need to deal with it.
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
	NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
}


/** We've connected to the peripheral, now we need to discover the services and characteristics to find the 'transfer' characteristic.
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
	NSLog(@"Peripheral Connected");
	
	// Stop scanning
	[self.centralManager stopScan];
	
	// Make sure we get the discovery callbacks
	peripheral.delegate = self;
	
	// Search only for services that match our UUID
	[peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
}


/** The Transfer Service was discovered
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
	if (error) {
		NSLog(@"Error discovering services: %@", [error localizedDescription]);
		return;
	}
	
	// Discover the characteristic we want...
	
	// Loop through the newly filled peripheral.services array, just in case there's more than one.
	for (CBService *service in peripheral.services) {
		[peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
	}
}


/** The Transfer characteristic was discovered.
 *  Once this has been found, we want to subscribe to it, which lets the peripheral know we want the data it contains
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
	// Deal with errors (if any)
	if (error) {
		NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
		return;
		
		// Again, we loop through the array, just in case.
		for (CBCharacteristic *characteristic in service.characteristics) {
			
			// And check if it's the right one
			if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
				
				// If it is, subscribe to it
				[peripheral setNotifyValue:YES forCharacteristic:characteristic];
			}
		}
		
	}
}
@end
