//
//  ViewController.m
//  FoodModels
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[[[AppDelegate sharedAppDelegate] monitor] setDelegate:self];
}

- (void)pay {
	[[[AppDelegate sharedAppDelegate]paymentsManager]	pay:@100.0];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
	[super presentViewController:viewControllerToPresent animated:flag completion:completion];
	
}
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
								 didCompletePayment:(PayPalPayment *)completedPayment {
	
	
	// Dismiss the PayPalPaymentViewController.
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
	// The payment was canceled; dismiss the PayPalPaymentViewController.
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didEnterCafeRegion:(NSString *)cafeId {
	UILabel *gotIt = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100,100)];
	gotIt.text = cafeId;
	[self.view addSubview:gotIt];
}

@end
