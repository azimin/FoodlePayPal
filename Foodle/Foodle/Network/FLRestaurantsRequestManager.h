//
//  FLRestaurantsRequestManager.h
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLRestaurantsRequestManager : NSObject
+ (FLRestaurantsRequestManager *)sharedInstance;
- (void)getRestaurantsWithBeaconId:(NSNumber *)beaconId completion:(void (^)(NSArray *history))completionHandler;
- (void)getRestaurantsCompletion:(void (^)(NSArray *))completionHandler;
@end
