//
//  ReceiveLocalNotificationService.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/15.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ReceiveLocalNotificationService: NSObject {
    
    func application(application: UIApplication, didReceiveLocalNotification userInfo :[NSObject : AnyObject]) {
        switch userInfo["type"] as! String {
        case "Talk" where application.applicationState == .Active:
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .Default, handler: nil))
            alertController.addAction(UIAlertAction(title: "詳細へ", style: .Default, handler: {(action) -> Void in
                if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                    appDelegate.openTalkDetailViewController()
                }
            }))
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                appDelegate.showAlert(alertController)
            }
        case "Talk" where application.applicationState == .Inactive:
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                appDelegate.openTalkDetailViewController()
            }
        case "Information":
            break
        default:
            break
        }
    }
    
}
