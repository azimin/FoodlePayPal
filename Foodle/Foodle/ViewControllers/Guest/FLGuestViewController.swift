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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.registerNib(UINib(nibName: "FLGuestCell", bundle: nil), forCellReuseIdentifier: "FLGuestCell");
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRectMake(0, 0, 0, 5))
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FLGuestCell", forIndexPath: indexPath) as FLGuestCell
        
        return cell
    }
    
}
