//
//  AppDelegate.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import APIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ErrorAlertProtocol {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        getTalksFromAPI()
        
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

extension AppDelegate: RealmSaveTalksProtocol {
    
    fileprivate func getTalksFromAPI() {
        let request = TalksAPIRequest()
        Session.send(request) { [weak self](result) in
            switch result {
            case .success(let talks):
                try? self?.save(talks: talks)
                NotificationCenter.default.post(name: Notification.Name(rawValue: PCJNotificationConfig.completeFetchDataNotification), object: nil)
            case .failure(let error):
                self?.showErrorAlart(with: error)
            }
        }
    }
    
}
