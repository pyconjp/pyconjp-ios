//
//  ReceiveLocalNotificationManager.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/15.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class ReceiveLocalNotificationManager: NSObject {
    
    func application(application: UIApplication, didReceiveLocalNotification userInfo: [NSObject : AnyObject]) {
        guard let type = userInfo["type"] as? String, id = userInfo["id"] as? Int, title = userInfo["id"] as? String, appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else { return }
        switch type {
        case "Talk" where application.applicationState == .Active:
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .Default, handler: nil))
            alertController.addAction(UIAlertAction(title: "詳細へ", style: .Default, handler: {(action) -> Void in
                appDelegate.openTalkDetailViewController(id, title: title)
            }))
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                appDelegate.showAlert(alertController)
            }
        case "Talk" where application.applicationState == .Inactive:
            appDelegate.openTalkDetailViewController(id, title: title)
        case "Information":
            break
        default:
            break
        }
    }
    
}
