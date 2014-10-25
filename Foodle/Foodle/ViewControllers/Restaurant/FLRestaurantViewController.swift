//
//  FLRestaurantViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

enum CellsType {
    case Restaurant, RestaurantInfo, ButtonsCells, PayCell
}

class FLRestaurantViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var payButtonConstraint: NSLayoutConstraint!
    
    var restaurant: FLRestaurantEntity = FLRestaurantEntity(restaurantName: "Swag", restaurantDescription: "bla bla bla blabla blabla bla bla bla bla bla bla bla bla blabla blabla bla bla blabla blabla bla bla bla bla blabla blabla blabla bla bla bla bla blabla bla", isIBecacon: true, restaurantImageURL: "test")
    var cells: [CellsType] = []
    var buttons: [String] = ["Menu", "Order", "Call the waiter"]
    var tableNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cells = [.Restaurant, .RestaurantInfo, .ButtonsCells, .PayCell]
       // tableNumber = 5
        
        self.tableView.registerNib(UINib(nibName: "FLRestaurantMainCell", bundle: nil), forCellReuseIdentifier: "FLRestaurantMainCell");
        self.tableView.registerNib(UINib(nibName: "FLRestaurantInfoCell", bundle: nil), forCellReuseIdentifier: "FLRestaurantInfoCell");
        self.tableView.registerNib(UINib(nibName: "FLButtonCell", bundle: nil), forCellReuseIdentifier: "FLButtonCell");
        self.tableView.registerNib(UINib(nibName: "FLRestaurantPayCell", bundle: nil), forCellReuseIdentifier: "FLRestaurantPayCell");
        
        payButton.backgroundColor = UIColor.appColor()

        if (tableNumber == nil) {
            payButton.setTitle("Select table", forState: .Normal)
        } else {
            payButton.setTitle("Pay", forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (tableNumber == nil) {
            return cells.count - 1
        }
        
        return cells.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = cells[section]
        if (type == .ButtonsCells) {
            if (tableNumber == nil) {
                return 1
            } else {
                return 3
            }
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let type = cells[indexPath.section]
        if (type == .Restaurant) {
            let cell = tableView.dequeueReusableCellWithIdentifier("FLRestaurantMainCell", forIndexPath: indexPath) as FLRestaurantMainCell
            
            cell.fillWithRestaurant(restaurant)

            return cell
        } else if (type == .RestaurantInfo) {
            let cell = tableView.dequeueReusableCellWithIdentifier("FLRestaurantInfoCell", forIndexPath: indexPath) as FLRestaurantInfoCell
            
            cell.fillWithRestaurant(restaurant, tableNumber: tableNumber)
            
            return cell
        } else if (type == .ButtonsCells) {
            let cell = tableView.dequeueReusableCellWithIdentifier("FLButtonCell", forIndexPath: indexPath) as FLButtonCell
            cell.buttonTextLabel.text = buttons[indexPath.row]
            cell.showAccesorise(!(indexPath.row < 2))
            
            return cell
        } else if (type == .PayCell) {
            let cell = tableView.dequeueReusableCellWithIdentifier("FLRestaurantPayCell", forIndexPath: indexPath) as FLRestaurantPayCell
            cell.billLabel.text = "31.5$"
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func updateData() {
        if (tableNumber == nil) {
            payButton.setTitle("Select table", forState: .Normal)
        } else {
            payButton.setTitle("Pay", forState: .Normal)
        }
        
        tableView.reloadData()
    }

    // MARK: - Action
    @IBAction func buttonAction(sender: UIButton) {
        let alertView = UIAlertView(title: "", message: "Enter number of your table", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Select")
        alertView.alertViewStyle = .PlainTextInput
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        let textField = alertView.textFieldAtIndex(0)
        if buttonIndex != 0 {
            if let tableNum = textField?.text.toInt() {
                tableNumber = tableNum
                updateData()
            }
        }
    }
}
