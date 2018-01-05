//
//  AppDelegate.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/02/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import APIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ErrorAlertProtocol {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        getTalksFromAPI()
        
        UINavigationBar.appearance().barTintColor = UIColor.PyConJP2017.navy
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
        UITabBar.appearance().tintColor = UIColor.PyConJP2017.yellow
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor.PyConJP2017.yellow], for: .selected)
        
        let configuration = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = configuration
        
        return true
    }
    
}

extension AppDelegate {
    
    fileprivate func getTalksFromAPI() {
        let request = TalksAPIRequest()
        Session.send(request) { [weak self](result) in
            switch result {
            case .success(let talks):
                try? SaveTalksRequest().save(talks: talks)
                NotificationCenter.default.post(name: Notification.Name(rawValue: PCJNotificationConfig.completeFetchDataNotification), object: nil)
            case .failure(let error):
                self?.showErrorAlart(with: error)
            }
        }
    }
    
}
