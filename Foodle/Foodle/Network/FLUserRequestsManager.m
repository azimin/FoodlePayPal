//
//  FLUserRequestsManager.m
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLUserRequestsManager.h"
#import "FLHTTPRequestOperationManager.h"
#import "Foodle-Swift.h"

@implementation FLUserRequestsManager
- (void)registerCustomer:(NSString *)installationId name:(NSString *)username {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/customer/register/" parameters:@{@"parseInstallationId":installationId,
																																														@"name":username} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			FLUserEntity *user = [[FLUserEntity alloc] init];
			user.userName = username;
			user.userId = responseData[@"id"];
			[[FLModelHolder sharedInstance] setCurrentUser:user];
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];
}

- (void)registerManager:(NSString *)installationId name:(NSString *)username {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/restaurantManager/register/" parameters:@{@"parseInstallationId":installationId,
																																												@"name": username,
																																												@"restaurantId":@100} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			FLUserEntity *user = [[FLUserEntity alloc] init];
			user.userName = username;
			user.userId = responseData[@"id"];
			[[FLModelHolder sharedInstance] setCurrentUser:user];
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
		
	}];
}

- (void)getUserOrdersHistory:(void (^)(NSArray *history))completionHandler {
	[[FLHTTPRequestOperationManager getBasicManager] GET:@"/order/start/" parameters:@{@"userId":@100} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			//Parse
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

- (void)getUserPreferences:(void (^)(NSArray *preferences))completionHandler {
	[[FLHTTPRequestOperationManager getBasicManager] GET:@"/order/start/" parameters:@{@"userId":@100} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
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
@end
