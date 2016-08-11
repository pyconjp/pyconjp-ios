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
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let fireDate = calendar?.dateByAddingUnit(.Minute, value: -10, toDate: date, options: NSCalendarOptions())
        
        if fireDate!.timeIntervalSinceNow > 0 {
            self.schedule(talkDetail)
            return true
        } else {
            return false
        }
    }
    
    private func schedule(talkDetail: TalkDetail) {
        
        guard let date = talkDetail.talkObject.date else { return }
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let fireDate =  calendar?.dateByAddingUnit(.Minute, value: -10, toDate: date, options: NSCalendarOptions())
        let userInfo = ["type": "Talk", "id": talkDetail.talkObject.id, "title": talkDetail.talkObject.title] as [NSObject : AnyObject]
        
        let notificaiton = UILocalNotification()
        notificaiton.fireDate = fireDate
        notificaiton.timeZone = NSTimeZone.systemTimeZone()
        notificaiton.alertBody = "10分後に \" \(talkDetail.talkObject.title) \" が開始します。 \(talkDetail.talkObject.place)"
        notificaiton.userInfo = userInfo
        
        UIApplication.sharedApplication().scheduleLocalNotification(notificaiton)
        
    }
    
    func cancelSchedule(talkDetail: TalkDetail) {
        if let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications {
            localNotifications.forEach({ (notification) -> () in
                if let userInfo = notification.userInfo {
                    if userInfo["id"] as! Int == talkDetail.talkObject.id {
                        UIApplication.sharedApplication().cancelLocalNotification(notification)
                    }
                }
            })
        }
    }
    
}
