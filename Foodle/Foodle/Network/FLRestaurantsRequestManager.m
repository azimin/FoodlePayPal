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

@implementation FLRestaurantsRequestManager

- (void)getRestaurantsWithBeaconId:(NSNumber *)beaconId completion:(void (^)(NSArray *))completionHandler {
	NSMutableDictionary *params = [NSMutableDictionary new];
	if (beaconId) params[@"beaconId"] = beaconId;
	[[FLHTTPRequestOperationManager getBasicManager] GET:@"/restaurant/listByiBeacon/" parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			//Parse
			NSArray *restaurants = [self parseRestaurantsWithData:responseData];
			[FLModelHolder sharedInstance].restaurants = restaurants;
			
			if (completionHandler)
				completionHandler(responseData);
		} failure:^(id responseData) {
			if (completionHandler)
				completionHandler(nil);
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
		if (completionHandler)
			completionHandler(nil);
	}];
}

- (void)getRestaurantsCompletion:(void (^)(NSArray *))completionHandler {
	[[FLHTTPRequestOperationManager getBasicManager] GET:@"/restaurant/list/" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			//Parse
			NSArray *restaurants = [self parseRestaurantsWithData:responseData];
			[FLModelHolder sharedInstance].restaurants = restaurants;
			
			if (completionHandler)
				completionHandler(responseData);
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
		entity.restaurantId = [restData[@"restaurantId"] integerValue];
		entity.restaurantDescription = restData[@"description"];
		entity.restaurantInfo = restData[@"info"];
		entity.restaurantImageURL = restData[@"photo"];
		entity.restaurantRange = [restData[@"range"] doubleValue];
		
		if ([restData[@"iBeacon"] boolValue])
			entity.isIBecacon = YES;
		else
			entity.isIBecacon = NO;

	}
	return restaurants;
}
@end
