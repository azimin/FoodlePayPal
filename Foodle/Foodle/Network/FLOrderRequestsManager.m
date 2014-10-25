//
//  FLOrderRequestsManager.m
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLOrderRequestsManager.h"
#import "FLHTTPRequestOperationManager.h"
@implementation FLOrderRequestsManager

- (void)startOrder {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/initialize/" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];
}

- (void)addDish:(id)dish {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/addDish/" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];

}

- (void)updateDish:(id)dish toAmount:(NSUInteger)newAmount {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/update/" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];

}

- (void)payForOrderWithInfo:(NSData *)confirmation {

	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/finish/" parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];

}
@end
