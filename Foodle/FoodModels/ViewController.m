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
	[[[AppDelegate sharedAppDelegate]paymentsManager] setDelegate:self];
	
	[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(pay) userInfo:nil repeats:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)pay {
		[[[AppDelegate sharedAppDelegate]paymentsManager]	pay:@10];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
