//
//  FLUserRequestsManager.h
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLUserRequestsManager : NSObject

- (void)registerCustomer:(NSString *)installationId;
- (void)registerManager:(NSString *)installationId;
- (void)getUserOrdersHistory:(void (^)(NSArray *history))completionHandler;
- (void)getUserPreferences:(void (^)(NSArray *preferences))completionHandler;

@end
