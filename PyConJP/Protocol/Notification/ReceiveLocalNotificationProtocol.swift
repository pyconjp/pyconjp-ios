//
//  ReceiveLocalNotificationProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/03/15.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol ReceiveLocalNotificationProtocol {}

extension ReceiveLocalNotificationProtocol {
    
    func handle(_ application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        guard let type = notification.userInfo?["type"] as? String,
            let id = notification.userInfo?["id"] as? Int,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let notificationType = NotificationType(type) else { return }
        
        switch notificationType {
        case .information:break
        case .talk where application.applicationState == .active:
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
            alertController.addAction(UIAlertAction(title: "詳細へ", style: .default, handler: { _ -> Void in
                appDelegate.openTalkDetailViewController(id: id)
            }))
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.showAlert(alertController: alertController)
            }
        case .talk where application.applicationState == .inactive:
            appDelegate.openTalkDetailViewController(id: id)
        default:
            break
        }
    }
    
}
