//
//  ETHTTPRequestOperationManager.h
//  easyten
//
//  Created by Nikita Pestrov on 25.08.14.
//  Copyright (c) 2014 cognitico. All rights reserved.
//

#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#define kCustomerID 7
#define restaurantManagerId 1
#define kReataurantId 18

@interface FLHTTPRequestOperationManager : AFHTTPRequestOperationManager

+ (AFHTTPRequestOperationManager *)getBasicManager;
+ (void)parseResponse:(id)response data:(NSData *)data withSuccess:(void (^)(id responseData))success failure:(void (^)(id responseData))failure;
@end
