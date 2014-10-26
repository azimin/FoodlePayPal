//
//  FLOrderRequestsManager.h
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLOrderRequestsManager : NSObject

- (void)startOrderAtTable:(NSNumber *)tableNumber;
- (void)addDish:(id)dish;
- (void)updateDish:(id)dish toAmount:(NSUInteger)newAmount;
- (void)payForOrderWithInfo:(NSData *)confirmation;
- (void)getOrder:(NSNumber *)orderId completion:(void (^)(NSArray *dishes))completionHandler;
@end
