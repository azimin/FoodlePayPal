//
//  FLOrderRequestsManager.m
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLOrderRequestsManager.h"
#import "FLHTTPRequestOperationManager.h"
#import "Foodle-Swift.h"

@implementation FLOrderRequestsManager

- (void)startOrderAtTable:(NSNumber *)tableNumber {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/initialize/" parameters:@{@"customerId":@(kCustomerID),
																																													 @"restaurantId":@(kReataurantId),
																																													 @"restaurantManagerId":@(restaurantManagerId),
																																													 @"tableNumber":tableNumber} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			[[FLModelHolder sharedInstance] setOrderId:[responseData[@"orderId"] unsignedIntegerValue]];
		} failure:^(id responseData) {
			
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
	}];
}

- (void)addDish:(id)dish {
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/addItem/" parameters:@{@"orderId":@([[FLModelHolder sharedInstance] orderId]),
																																												@"menuItemId":@(8),
																																												@"quantity":@(1)} success:^(AFHTTPRequestOperation *operation, id response) {
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

- (void)getOrder:(NSNumber *)orderId completion:(void (^)(NSArray *))completionHandler {
	NSArray *dishes = [self getSomeOrderData];
	[FLModelHolder sharedInstance].orderedDishes = dishes;
	if (completionHandler)
		completionHandler(dishes);
	return;
	
	[[FLHTTPRequestOperationManager getBasicManager] POST:@"/order/get/" parameters:@{@"orderId":orderId,
																																										@"customerId":[[[FLModelHolder sharedInstance] currentUser] userId]} success:^(AFHTTPRequestOperation *operation, id response) {
		[FLHTTPRequestOperationManager parseResponse:response data:operation.responseData withSuccess:^(id responseData) {
			NSArray *dishes = [self parseOrderWithData:responseData[@"dishes"]];
			[FLModelHolder sharedInstance].orderedDishes = dishes;
			if (completionHandler)
				completionHandler(dishes);
		} failure:^(id responseData) {
			if (completionHandler)
				completionHandler(nil);
		}];
	} failure:^(AFHTTPRequestOperation *operation, NSError *err) {
		if (completionHandler)
			completionHandler(nil);
	}];

}

- (NSArray *)parseOrderWithData:(NSArray *)responseData {
	
	NSMutableArray *dishes = [NSMutableArray new];
	for (NSDictionary *restData in responseData) {
		
		FLDishEntity *entity = [[FLDishEntity alloc] init];
		entity.dishCategory = restData[@"category"];
		entity.dishPrice = [restData[@"price"] doubleValue];
		entity.dishDescription = restData[@"description"];
		entity.dishPriority = [restData[@"rating"] integerValue];
		entity.dishImageURL = restData[@"photo"];
		entity.count = [restData[@"amount"] integerValue];
		
	[dishes addObject:entity];
	}
	return dishes;
}

- (NSArray *)getSomeOrderData {
	NSMutableArray *dishes = [NSMutableArray new];
	[dishes addObject:[[FLDishEntity alloc] initWithDishName:@"Coctail" dishDescription:@"So great!" dishImageURL:@"coctailImage" dishPrice:35.5 dishCategory:@"Coctails"]];
	[dishes addObject:[[FLDishEntity alloc] initWithDishName:@"Coctail me" dishDescription:@"So great too!" dishImageURL:@"coctailImage" dishPrice:55.5 dishCategory:@"Coctails"]];
	[dishes addObject:[[FLDishEntity alloc] initWithDishName:@"Coctail" dishDescription:@"So great!" dishImageURL:@"coctailImage" dishPrice:35.5 dishCategory:@"Meat"]];
	[dishes addObject:[[FLDishEntity alloc] initWithDishName:@"Coctail" dishDescription:@"So great!" dishImageURL:@"coctailImage" dishPrice:35.5 dishCategory:@"Coctails"]];
	return dishes;
}
@end
