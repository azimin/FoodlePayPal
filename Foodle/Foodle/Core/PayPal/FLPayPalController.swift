//
//  FLPayPalController.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLPayPalController: NSObject, PayPalPaymentDelegate {
    
    var currentController: UIViewController?
    
    func presentViewController(viewControllerToPresent: UIViewController) {
        currentController?.presentViewController(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        currentController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        
    }
}
