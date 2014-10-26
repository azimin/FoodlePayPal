//
//  FLRestaurantsViewController.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLRestaurantsViewController: FLBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var restaurants: [FLRestaurantEntity] = []
    let identifier = "FLRestaurantCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: UIBarButtonItemStyle.Done, target: self, action: Selector("openSettings"))
        
        restaurants.append(FLRestaurantEntity(restaurantName: "Swag", restaurantDescription: "bla bla bla blabla blabla bla bla bla bla bla bla bla bla blabla blabla bla bla blabla blabla bla bla bla bla blabla blabla blabla bla bla bla bla blabla bla", isIBecacon: true, restaurantImageURL: "test"))
        restaurants.append(FLRestaurantEntity(restaurantName: "Swag", restaurantDescription: "bla bla bla blabla blabla bla ba", isIBecacon: false, restaurantImageURL: "test"))
        restaurants.append(FLRestaurantEntity(restaurantName: "Swag", restaurantDescription: "bla bla bla blabla blabla bla bla bla bla bla bla bla bla blabla blabla bla bla blabla blabla bla bla bla bla blabla bla", isIBecacon: false, restaurantImageURL: ""))
        self.tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier);
    }
    
    func openSettings() {
        
    }
    
    // MARK: - TableView Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return restaurants.count
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
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as FLRestaurantCell
        
        cell.fillWithRestaurant(restaurants[indexPath.section])
        
        var needToShow = false
        if (indexPath.section < 2) {
            needToShow = true
        }
        cell.showImage(needToShow)
        
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let restauerantsVC = FLRestaurantViewController(nibName: "FLRestaurantViewController", bundle: nil)
        self.navigationController?.pushViewController(restauerantsVC, animated: true)
        
        AppDelegate.sharedAppDelegate().emitateBillWindow()
    }
}
