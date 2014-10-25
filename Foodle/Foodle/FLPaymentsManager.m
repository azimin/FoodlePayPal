//
//  FLPaymentsManager.m
//  Foodle
//
//  Created by Nikolay Pestrov on 25.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "FLPaymentsManager.h"

@implementation FLPaymentsManager

- (instancetype)init {
	self = [super init];
	if (self) {
		[PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : @"AfdhBBDP7kD3n8bL_Q_6mjIODdBiIy_mkOzTTfVb2qwZAH_Sby9auZRmo28j"}];
		self.payPalConfiguration = [[PayPalConfiguration alloc] init];
		self.payPalConfiguration.acceptCreditCards = YES;
		self.payPalConfiguration.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
		[PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
	}
	return self;
}

- (void)pay:(NSNumber *)amount {
	
	PayPalPayment *payment = [[PayPalPayment alloc] init];
	
	// Amount, currency, and description
	payment.amount = [[NSDecimalNumber alloc] initWithString:amount.stringValue];
	payment.currencyCode = @"USD";
	payment.shortDescription = @"Awesome dishes";
	
	// Use the intent property to indicate that this is a "sale" payment,
	// meaning combined Authorization + Capture.
	// To perform Authorization only, and defer Capture to your server,
	// use PayPalPaymentIntentAuthorize.
	// To place an Order, and defer both Authorization and Capture to
	// your server, use PayPalPaymentIntentOrder.
	// (PayPalPaymentIntentOrder is valid only for PayPal payments, not credit card payments.)
	payment.intent = PayPalPaymentIntentSale;
	
	
	// Several other optional fields that you can set here are documented in PayPalPayment.h,
	// including paymentDetails, items, invoiceNumber, custom, softDescriptor, etc.

	PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
																																															configuration:self.payPalConfiguration
																																																	 delegate:self.delegate];
	
	// Present the PayPalPaymentViewController.
	[self.delegate presentViewController:paymentViewController animated:YES completion:nil];
	
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
	// Send the entire confirmation dictionary
	NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
																												 options:0
																													 error:nil];
	
	// Send confirmation to your server; your server should verify the proof of payment
	// and give the user their goods or services. If the server is not reachable, save
	// the confirmation and try again later.
}

@end
