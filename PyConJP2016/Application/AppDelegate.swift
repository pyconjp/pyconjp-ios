//
//  AppDelegate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TalksAPIType, ErrorAlertType {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
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
        
        getTalks(successClosure: {
            NSNotificationCenter.defaultCenter().postNotificationName(AppConfig.PCJCompleteFetchDataNotification, object: nil)
        }) {(error) in
            self.showErrorAlartWith(error, parent: nil)
        }
        
        UINavigationBar.appearance().barTintColor = .pyconJP2016RedColor()
        UINavigationBar.appearance().tintColor = .whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UITabBar.appearance().tintColor = UIColor.pyconJP2016BlueColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(10), NSForegroundColorAttributeName: UIColor.pyconJP2016BlueColor()], forState: .Selected)
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if let userInfo = notification.userInfo {
            let receiveLocalNotificationManager = ReceiveLocalNotificationManager()
            receiveLocalNotificationManager.application(application, didReceiveLocalNotification: userInfo)
        }
        
        UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
    
}
