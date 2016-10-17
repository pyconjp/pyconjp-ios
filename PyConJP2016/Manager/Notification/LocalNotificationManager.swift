//
//  LocalNotificationManager.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/13/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class LocalNotificationManager: NSObject {
    
    func makeNotification(talkDetail: TalkDetail) -> Bool {
        
        guard let date = talkDetail.talkObject.date else { return false }
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let fireDate = (calendar as NSCalendar?)?.date(byAdding: .minute, value: -10, to: date as Date, options: NSCalendar.Options())
        
        if fireDate!.timeIntervalSinceNow > 0 {
            self.schedule(talkDetail: talkDetail)
            return true
        } else {
            return false
        }
    }
    
    private func schedule(talkDetail: TalkDetail) {
        
        guard let date = talkDetail.talkObject.date else { return }
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let fireDate =  (calendar as NSCalendar?)?.date(byAdding: .minute, value: -10, to: date as Date, options: NSCalendar.Options())
        let userInfo = ["type": "Talk", "id": talkDetail.talkObject.id] as [AnyHashable: Any]
        
        let notificaiton = UILocalNotification()
        notificaiton.fireDate = fireDate
        notificaiton.timeZone = TimeZone.current
        notificaiton.alertBody = "10分後に \" \(talkDetail.talkObject.title) \" が開始します。 \(talkDetail.talkObject.place)"
        notificaiton.userInfo = userInfo
        
        UIApplication.shared.scheduleLocalNotification(notificaiton)
        
    }
    
    func cancelSchedule(talkDetail: TalkDetail) {
        if let localNotifications = UIApplication.shared.scheduledLocalNotifications {
            localNotifications.forEach({ (notification) -> () in
                if let userInfo = notification.userInfo {
                    if userInfo["id"] as! Int == talkDetail.talkObject.id {
                        UIApplication.shared.cancelLocalNotification(notification)
                    }
                }
            })
        }
    }
    
}
