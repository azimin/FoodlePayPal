//
//  FLUserInfoViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLUserInfoViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    var preferences: [FLPreferenceEntity] = []
    var order: [FLDishEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControll.tintColor = UIColor.appColor()

        self.tableView.registerNib(UINib(nibName: "FLPreferenceCell", bundle: nil), forCellReuseIdentifier: "FLPreferenceCell");
        self.tableView.registerNib(UINib(nibName: "FLOrderCell", bundle: nil), forCellReuseIdentifier: "FLOrderCell");
        // Do any additional setup after loading the view.
        
        var dish = FLDishEntity(dishName: "Coctail", dishDescription: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla blabla bla bla bla bla bla bla bla bla bla bla", dishImageURL: "coctailImage", dishPrice: 10.6, dishCategory: "Meat")
        dish.count = 2
        
        var dish2 = FLDishEntity(dishName: "Burger", dishDescription: "bla bla bla b", dishImageURL: "coctailImage", dishPrice: 12.6, dishCategory: "Meat")
        dish2.count = 1
        
        var dish3 = FLDishEntity(dishName: "Cheese", dishDescription: "bla bla bla b", dishImageURL: "coctailImage", dishPrice: 5.5, dishCategory: "Meat")
        dish3.count = 1
        
        order.append(dish)
        order.append(dish2)
        order.append(dish3)
        
        preferences.append(FLPreferenceEntity(name: "Fruits", count: 11))
        preferences.append(FLPreferenceEntity(name: "Cheese", count: 10))
        preferences.append(FLPreferenceEntity(name: "Beef", count: 8))
        preferences.append(FLPreferenceEntity(name: "Rice", count: 4))
        preferences.append(FLPreferenceEntity(name: "Spices", count: 1))
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if segmentControll.selectedSegmentIndex == 0 {
            return order.count + 1
        }
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 && segmentControll.selectedSegmentIndex == 0 {
            return nil
        }
        return UIView(frame: CGRectMake(0, 0, 0, 5))
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 && segmentControll.selectedSegmentIndex == 0 {
            return "Current order"
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 && segmentControll.selectedSegmentIndex == 0 {
            return 40
        }
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return (segmentControll.selectedSegmentIndex == 0) ? 1 : preferences.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if (segmentControll.selectedSegmentIndex == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("FLPreferenceCell", forIndexPath: indexPath) as FLPreferenceCell
                
                cell.fillWithName("Table", infoString: "10", iconImageName: "TableI")
                
                return cell
            } else {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
                cell.textLabel.text = "History"
                cell.textLabel.textColor = UIColor.appColor()
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return cell
            }
        } else {
            if (segmentControll.selectedSegmentIndex == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("FLOrderCell", forIndexPath: indexPath) as FLOrderCell
                cell.enableSetCount = false
                cell.isWeiter = true
                
                if (indexPath.section == 2) {
                    cell.isReady = true
                }
                
                cell.fillWithDish(order[indexPath.section - 1])
                
                return cell
            } else {
                let preference = preferences[indexPath.row]
                let cell = tableView.dequeueReusableCellWithIdentifier("FLPreferenceCell", forIndexPath: indexPath) as FLPreferenceCell
                
                cell.fillWithName(preference.name, infoString: "\(preference.count)", iconImageName: preference.name + "I")
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    // MARK: - Segment

    @IBAction func segmentControlAction(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            println("Swn")
        } else {
            println("asd")
        }
        tableView.reloadData()
    }
}
