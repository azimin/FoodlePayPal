//
//  FLOrderViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLOrderViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var order: [FLDishEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FLOrderCell", bundle: nil), forCellReuseIdentifier: "FLOrderCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FLOrderCell", forIndexPath: indexPath) as FLOrderCell
        
        if indexPath.row == 1 {
            cell.enableSetCount = false
        }
        
        cell.fillWithDish(order[indexPath.row])
        
        return cell
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

}
