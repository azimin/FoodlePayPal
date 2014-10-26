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
        dishes.append(FLDishEntity(dishName: "Coctail", dishDescription: "bla bla", dishImageURL: "coctailImage", dishPrice: 35.5, dishCategory: "Coctails"))
        dishes.append(FLDishEntity(dishName: "Coctail", dishDescription: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla", dishImageURL: "coctailImage", dishPrice: 25.5, dishCategory: "Coctails"))
        dishes.append(FLDishEntity(dishName: "Coctail", dishDescription: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla blabla bla bla bla bla bla bla bla bla bla bla", dishImageURL: "coctailImage", dishPrice: 10.6, dishCategory: "Meat"))
        
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
