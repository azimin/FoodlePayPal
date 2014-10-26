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
	FLRestaurantsRequestManager	*restaurantsManager = [[FLRestaurantsRequestManager alloc] init];
	[restaurantsManager getRestaurantsWithBeaconId:self.beaconRegion.major completion:nil];
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
		NSLog(@"Immediate");
	} else if (beacon.proximity == CLProximityNear) {
		NSLog(@"Near");
	} else if (beacon.proximity == CLProximityFar) {
		NSLog(@"FAR");
	}
}
- (BOOL)isARestaurantRegion:(CLBeaconRegion *)region {
	if ([region.proximityUUID.UUIDString isEqualToString:beaconUUID]) {
		return YES;
	}
	return YES;
}
@end
