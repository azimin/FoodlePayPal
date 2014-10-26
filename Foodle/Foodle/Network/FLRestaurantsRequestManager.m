//
//  FLRestaurantsRequestManager.m
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLRestaurantsRequestManager.h"
#import "FLHTTPRequestOperationManager.h"
#import "Foodle-Swift.h"
@interface FLRestaurantsRequestManager ()
@property BOOL isFetching;
@end

@implementation FLRestaurantsRequestManager

+ (FLRestaurantsRequestManager *)sharedInstance
{
	static FLRestaurantsRequestManager *sharedInstance;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

- (void)getRestaurantsWithBeaconId:(NSNumber *)beaconId completion:(void (^)(NSArray *))completionHandler {
	if (self.isFetching)
		return;
	self.isFetching = YES;
	NSMutableDictionary *params = [NSMutableDictionary new];
	if (beaconId) params[@"beaconId"] = beaconId;
	[[FLHTTPRequestOperationManager getBasicManager] GET:@"/restaurant/listByiBeacon/" parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			//Parse
			NSArray *restaurants = [self parseRestaurantsWithData:responseData[@"restaurants"]];
			
			[FLModelHolder sharedInstance].restaurants = restaurants;
			self.isFetching = NO;
			if (completionHandler)
				completionHandler(responseData);
			[[NSNotificationCenter defaultCenter] postNotificationName:@"restsurantsListUpdatedWithBeacon" object:nil];
		} failure:^(id responseData) {
			self.isFetching = NO;
			if (completionHandler)
				completionHandler(nil);
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
		self.isFetching = NO;
		if (completionHandler)
			completionHandler(nil);
	}];
}

- (void)getRestaurantsCompletion:(void (^)(NSArray *))completionHandler {
	[[FLHTTPRequestOperationManager getBasicManager] GET:@"/restaurant/list/" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			//Parse
			NSArray *restaurants = [self parseRestaurantsWithData:responseData[@"restaurants"]];
			[FLModelHolder sharedInstance].restaurants = restaurants;
			
			if (completionHandler)
				completionHandler(responseData);
			[[NSNotificationCenter defaultCenter] postNotificationName:@"restsurantsListUpdated" object:nil];
			
		} failure:^(id responseData) {
			if (completionHandler)
				completionHandler(nil);
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
		if (completionHandler)
			completionHandler(nil);
	}];
}

- (NSArray *)parseRestaurantsWithData:(NSArray *)responseData {
	NSMutableArray *restaurants = [NSMutableArray new];
	for (NSDictionary *restData in responseData) {
		
		FLRestaurantEntity *entity = [[FLRestaurantEntity alloc] init];
		entity.restaurantName = restData[@"name"];
		entity.restaurantId = [restData[@"id"] integerValue];
		entity.restaurantDescription = restData[@"description"];
		entity.restaurantInfo = restData[@"info"];
		entity.restaurantImageURL = restData[@"photo"];
		entity.restaurantRange = [restData[@"range"] doubleValue];
		
		if ([restData[@"iBeacon"] boolValue])
			entity.isIBecacon = YES;
		else
			entity.isIBecacon = NO;
		[restaurants addObject:entity];
	}
	return restaurants;
}
@end
