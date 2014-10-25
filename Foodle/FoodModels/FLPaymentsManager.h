//
//  FLPaymentsManager.h
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayPalMobile.h"

@interface FLPaymentsManager : NSObject
@property (nonatomic, strong, readwrite) PayPalConfiguration *payPalConfiguration;
@property (weak) UIViewController<PayPalPaymentDelegate> *delegate;

- (void)pay:(NSNumber *)amount;

@end
