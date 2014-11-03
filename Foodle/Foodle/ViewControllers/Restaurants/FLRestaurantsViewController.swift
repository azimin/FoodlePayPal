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
				restaurants = FLModelHolder.sharedInstance.restaurants
				NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateRestaurantsList:", name: "restsurantsListUpdated", object: nil)
			NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateRestaurantsListBeacon:", name: "restsurantsListUpdatedWithBeacon", object: nil)
				self.tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier);
        
        self.restaurants.append(FLRestaurantEntity(restaurantName: "La Belle Hortense", restaurantDescription: "Cafeine regroupe sous sa bannière les cafés et restaurants de Xavier Denamur en gestion direct, ses deux affaires données en gérance libre à Sébastien Bailleul et Rebus rachetée en 2012.", isIBecacon: true, restaurantImageURL: "LesPhilosophes.jpg"))
        self.restaurants.append(FLRestaurantEntity(restaurantName: "Torro Grill", restaurantDescription: "No matter what your expectations, at Torro Grill the largest grill and friendliest atmosphere in Moscow await.", isIBecacon: true, restaurantImageURL: "TorroGrill.JPG"))
        self.restaurants.append(FLRestaurantEntity(restaurantName: "Rockand Burger", restaurantDescription: "Empresa gastronómica GANADORA de La Salle del Pedregal, excelente servicio y calidad en sus productos. En Rock n' Burger tu fuiste feliz. Generación 2008 - 2011", isIBecacon: false, restaurantImageURL: "RockandBurger.jpg"))
        self.restaurants.append(FLRestaurantEntity(restaurantName: "Piggy Paint", restaurantDescription: "What's better than Jose's Mexican Restaurant famous for its great food, great service and great fun? It's here, just come and taste our cusine!", isIBecacon: false, restaurantImageURL: "PiggyPoint.jpg"))
    }
    
    func openSettings() {
        let restauerantsVC = FLStartViewController(nibName: "FLStartViewController", bundle: nil)
        let navigationVC = FLBaseNavigationController(rootViewController: restauerantsVC)
        self.presentViewController(navigationVC, animated: true, completion: nil)
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
			
			let resaurant = self.restaurants[indexPath.section];
			
        let restauerantsVC = FLRestaurantViewController(nibName: "FLRestaurantViewController", bundle: nil)
				restauerantsVC.restaurant = resaurant
			
			if resaurant.isIBecacon {
				restauerantsVC.tableNumber = Int(rand() % 10)

				FLOrderRequestsManager().startOrderAtTable(restauerantsVC.tableNumber)
			}
			
        self.navigationController?.pushViewController(restauerantsVC, animated: true)
        
       // AppDelegate.sharedAppDelegate().emitateBillWindow()
    }
	
	func updateRestaurantsList(notification: NSNotification) {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "restsurantsListUpdated", object: nil)
		restaurants = FLModelHolder.sharedInstance.restaurants
		self.tableView.reloadData()
	}
	func updateRestaurantsListBeacon(notification: NSNotification) {
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "restsurantsListUpdatedWithBeacon", object: nil)
		restaurants = FLModelHolder.sharedInstance.restaurants
		self.tableView.reloadData()
	}
}
