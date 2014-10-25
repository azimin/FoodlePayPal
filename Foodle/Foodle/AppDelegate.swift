//
//  AppDelegate.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow!
    
    var broadcaster: FLBeaconBroadcaster!
    var paymentsManager: FLPaymentsManager!
    var monitor: FLBeaconsMonitor!
    var kbroadCastBeacon = true

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // PARSE
        Parse.setApplicationId("NlFtrOa1uDCQd8uBgglTAWJpVNFZCQduxeLqiSsf", clientKey: "EWmFPAuHaFqP6hXI3W65r3WLTsYPvn6ObXFyVjmN")
        let type: UIUserNotificationType = UIUserNotificationType(UIUserNotificationType.Alert.rawValue | UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue)
        let set = NSSet(array: [registerForNotifiactionCategory()])
        let settings = UIUserNotificationSettings(forTypes: type, categories: set)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        // BEACONS
        if (kbroadCastBeacon) {
            self.broadcaster = FLBeaconBroadcaster()
            self.broadcaster.broadCastBeacon();
        } else {
            self.monitor = FLBeaconsMonitor()
        }
        self.paymentsManager = FLPaymentsManager()
        
        // WINDOW
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.makeKeyAndVisible()
        
        let restauerantsVC = FLGuestViewController(nibName: "FLGuestViewController", bundle: nil)
        let navigationVC = FLBaseNavigationController(rootViewController: restauerantsVC)

        window.rootViewController = navigationVC
        
        apperance()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Push
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["Bill", "Info"]
        currentInstallation.saveInBackgroundWithBlock(nil)
        println(currentInstallation.installationId)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        
        println(userInfo)
        // {"alert": "Your bill is 23.5$", "category" : "BILL_PAY"}
        //  "path": 1
        if let action = userInfo["path"]?.integerValue {
            if (action == 1) {
            } else if (action == 2) {
            }
        }
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        if identifier == nil {
            return
        }
        
        if (identifier == "ACTION_PAY") {
            println("pay")
            completionHandler()
        } else if (identifier == "ACTION_INFO") {
            completionHandler()
        }
    }
    
    // MARK: - Additional

    func apperance() {
        var textAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                              NSFontAttributeName: UIFont.mainFontWithSize(18)]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navBar"), forBarMetrics: UIBarMetrics.Default)
    }
    
    func registerForNotifiactionCategory() -> UIMutableUserNotificationCategory {
        let action1 = UIMutableUserNotificationAction()
        action1.activationMode = UIUserNotificationActivationMode.Background
        action1.title = "Pay"
        action1.identifier = "ACTION_PAY"
        action1.destructive = true
        action1.authenticationRequired = true
        
        let action2 = UIMutableUserNotificationAction()
        action2.activationMode = UIUserNotificationActivationMode.Foreground
        action2.title = "Show"
        action2.identifier = "ACTION_INFO"
        action2.destructive = false
        action2.authenticationRequired = false
        
        let actionCategory = UIMutableUserNotificationCategory()
        actionCategory.identifier = "BILL_PAY"
        actionCategory.setActions([action1, action2], forContext: UIUserNotificationActionContext.Default)
        return actionCategory
    }

}

