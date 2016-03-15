//
//  AppDelegate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/16.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)

//        if let _ = launchOptions![UIApplicationLaunchOptionsURLKey] as? [NSObject : AnyObject] {
//            if let osVersion = Float64(UIDevice.currentDevice().systemVersion) {
//                if osVersion >= 9.0 {
//                }
//            }
//        }
        if let launchOptions = launchOptions {
            if let localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification {
            	self.application(application, didReceiveLocalNotification: localNotification)
        	}
        }
        
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
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if let userInfo = notification.userInfo {
            let receiveLocalNotificationService = ReceiveLocalNotificationService()
            receiveLocalNotificationService.application(application, didReceiveLocalNotification: userInfo)
        }
        
        UIApplication.sharedApplication().cancelLocalNotification(notification)
    }
    
//    func openTalkDetailViewController() {
//        let talkDetailViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("TalkDetailViewController") as! TalkDetailViewController
//        talkDetailViewController.talk = nil
//        self.window?.rootViewController?.presentedViewController?.navigationController?.pushViewController(talkDetailViewController, animated: true)
//    }
}

