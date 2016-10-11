//
//  AppDelegate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TalksAPIProtocol, ErrorAlertProtocol {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //        let settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil)
        //        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        //
        //        if let _ = launchOptions![UIApplicationLaunchOptionsURLKey] as? [NSObject : AnyObject] {
        //            if let osVersion = Float64(UIDevice.currentDevice().systemVersion) {
        //                if osVersion >= 9.0 {
        //                }
        //            }
        //        }
        //        if let launchOptions = launchOptions {
        //            if let localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification {
        //                self.application(application, didReceiveLocalNotification: localNotification)
        //            }
        //        }
        
        getTalks { result in
            switch result {
            case .success:
            	NotificationCenter.default.post(name: Notification.Name(rawValue: PCJNotificationConfig.CompleteFetchDataNotification), object: nil)
            case .failure(let error):
                self.showErrorAlart(with: error)
            }
        }
        
        UINavigationBar.appearance().barTintColor = UIColor.PyConJP2016.red
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        UITabBar.appearance().tintColor = UIColor.PyConJP2016.blue
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.PyConJP2016.blue], for: .selected)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        if let userInfo = notification.userInfo {
            let receiveLocalNotificationManager = ReceiveLocalNotificationManager()
            receiveLocalNotificationManager.application(application, didReceiveLocalNotification: userInfo)
        }
        
        UIApplication.shared.cancelLocalNotification(notification)
    }
    
}
