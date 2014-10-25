//
//  FLUserRequestsManager.m
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLUserRequestsManager.h"
#import "FLHTTPRequestOperationManager.h"

@implementation FLUserRequestsManager
- (void)registerCustomer:(NSString *)installationId {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/user/register/" parameters:@{@"installationId":installationId,
																																												@"userId": [[NSUUID UUID] UUIDString]} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];
}

- (void)registerManager:(NSString *)installationId {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/user/register/" parameters:@{@"installationId":installationId,
																																												@"userId": [[NSUUID UUID] UUIDString]} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			
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
