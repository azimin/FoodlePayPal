//
//  FLBillViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLBillViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var addTipsButton: UIButton!
    var dishes: [FLDishEntity] = []
    @IBOutlet weak var tableView: UITableView!
    var totalCost: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, 0, 44))
        
        payButton.backgroundColor = UIColor(fromHexString: "73b576")
        addTipsButton.backgroundColor = UIColor(fromHexString: "6f8ab4")
        self.tableView.registerNib(UINib(nibName: "FLHeaderBillCell", bundle: nil), forCellReuseIdentifier: "FLHeaderBillCell");
        self.tableView.registerNib(UINib(nibName: "FLBillCell", bundle: nil), forCellReuseIdentifier: "FLBillCell");
        //
        // Do any additional setup after loading the view.
        
        for dish in dishes {
            totalCost += CGFloat(dish.count) * dish.dishPrice
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        
        return dishes.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("FLHeaderBillCell", forIndexPath: indexPath) as FLHeaderBillCell
            
            cell.infoView.text = (indexPath.section == 0) ? "Your bill cost" : "Dishes"
            
            return cell
        } else {
            if (indexPath.section == 0) {
                let cell = tableView.dequeueReusableCellWithIdentifier("FLBillCell", forIndexPath: indexPath) as FLBillCell
                
                cell.fillWithCash(totalCost)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("FLBillCell", forIndexPath: indexPath) as FLBillCell
                
                let dish = dishes[indexPath.row - 1]
                cell.fillWithNameAndInfo(dish.dishName, info: "\(CGFloat(dish.count) * dish.dishPrice)$")
                
                return cell
            }
        }
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        cell.detailTextLabel?.text = "Swag"
        return cell
    }
    
    
    @IBAction func payButtonAction(sender: UIButton) {
        AppDelegate.sharedAppDelegate().closeBillWindow(true, price: totalCost)
    }
    
    @IBAction func addTipsButton(sender: UIButton) {
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
