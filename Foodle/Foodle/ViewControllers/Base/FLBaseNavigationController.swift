//
//  FLBaseNavigationController.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - PayPalDelegate
    
    func presentViewController(viewControllerToPresent: UIViewController) {
        self.viewControllers.last!.presentViewController(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        self.viewControllers.last!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        self.viewControllers.last!.dismissViewControllerAnimated(true, completion: nil)
    }

}
