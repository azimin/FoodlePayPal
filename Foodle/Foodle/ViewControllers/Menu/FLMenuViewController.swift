//
//  FLMenuViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLMenuViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource, FLDishTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    var dishesCategories: [String: [FLDishEntity]] = [:]
    var keys: [String] = []
    var order: [FLDishEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var dishes: [FLDishEntity] = []
        dishes.append(FLDishEntity(dishName: "Shaverma", dishDescription: "Great taste dish", dishImageURL: "HOT_shaverma.png", dishPrice: 8.0, dishCategory: "Meat", priority: 1))
        dishes.append(FLDishEntity(dishName: "Steak", dishDescription: "A steak is a cut of meat sliced perpendicular to the muscle fibers, potentially including a bone.", dishImageURL: "HOT_steak", dishPrice: 18.5, dishCategory: "Meat", priority: 1))
        dishes.append(FLDishEntity(dishName: "Tartini", dishDescription: "A sampling from our menu, each of these dishes are made to the highest Slovenian and Italian standards.", dishImageURL: "HOT_Tartini", dishPrice: 10.5, dishCategory: "Meat", priority: -1))
        dishes.append(FLDishEntity(dishName: "Red coctail", dishDescription: "Coctail with chery taste.", dishImageURL: "DRINKS_RED", dishPrice: 10.6, dishCategory: "Coctails"))
        
        dishesCategories = FLDishEntity.filterDishes(dishes)
        keys = dishesCategories.keys.array
        
        self.tableView.registerNib(UINib(nibName: "FLDishTableViewCell", bundle: nil), forCellReuseIdentifier: "FLDishTableViewCell");
        orderButton.backgroundColor = UIColor.appColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let newArray = dishesCategories[keys[section]] {
            return newArray.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FLDishTableViewCell", forIndexPath: indexPath) as FLDishTableViewCell
        
        if let dishes = dishesCategories[keys[indexPath.section]] {
            cell.fillWithDish(dishes[indexPath.row])
            cell.delegate = self
        }
        
        return cell
    }
    
    func dishCellSelected(cell: FLDishTableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)
        addOrderAtIndexPath(indexPath!)
    }
    
    func addOrderAtIndexPath(indexPath: NSIndexPath) {
        if let dish = dishesCategories[keys[indexPath.section]]?[indexPath.row] {
            let index = find(order, dish)
            if let findedIndex = index {
                order[findedIndex].count++
            } else {
                order.append(dish)
                dish.count = 1
            }
        }
        
        var sum: CGFloat = 0.0
        for el in order {
            sum += el.dishPrice * CGFloat(el.count)
        }
        orderPriceLabel.text = "\(sum)$"
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as FLDishTableViewCell
        let snapshot = cell.addButton.pb_takeSnapshot()
        
        let imgView = UIImageView(frame: cell.addButton.frame)
        imgView.image = snapshot
        cell.addSubview(imgView)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            imgView.y += 1000
        })
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func goToOrderButtonAction(sender: UIButton) {
        let restauerantsVC = FLOrderViewController(nibName: "FLOrderViewController", bundle: nil)
        restauerantsVC.order = order
        self.navigationController?.pushViewController(restauerantsVC, animated: true)
    }

}
