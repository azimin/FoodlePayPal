//
//  FLGuestViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLGuestViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [FLUserEntity] = []
    
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: UIBarButtonItemStyle.Done, target: self, action: Selector("openSettings"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("openMenu"))
        
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FLGuestCell", bundle: nil), forCellReuseIdentifier: "FLGuestCell");
        // Do any additional setup after loading the view.
        users.append(FLUserEntity(userName: "Alex", userBill: 25.5, userNewDishes: 3, userTable: 8))
        users.append(FLUserEntity(userName: "Nikita Pe", userBill: 5.5, userNewDishes: 0, userTable: 1))
        users.append(FLUserEntity(userName: "Martin ", userBill: 45.5, userNewDishes: 13, userTable: 14))
        users.append(FLUserEntity(userName: "Mari De Tori", userBill: 10.5, userNewDishes: 0, userTable: 12))
        users.append(FLUserEntity(userName: "Pay Palich", userBill: 20.5, userNewDishes: 0, userTable: 3))
    }
    
    func openSettings() {
        
    }
    
    func openMenu() {
        //[[[AppDelegate sharedAppDelegate]paymentsManager]	pay:@100.0];
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRectMake(0, 0, 0, 5))
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FLGuestCell", forIndexPath: indexPath) as FLGuestCell
        
        cell.fillWithUser(users[indexPath.section])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let restauerantsVC = FLUserInfoViewController(nibName: "FLUserInfoViewController", bundle: nil)
        self.navigationController?.pushViewController(restauerantsVC, animated: true)
    }
    
    // MARK: - PayPalDelegate
    
    func presentViewController(viewControllerToPresent: UIViewController) {
        self.presentViewController(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController, didCompletePayment completedPayment: PayPalPayment) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
