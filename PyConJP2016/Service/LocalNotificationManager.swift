//
//  LocalNotificationManager.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/13/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class LocalNotificationManager: NSObject {
    
    func makeNotification(talk: Talk) -> Bool {
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let fireDate = calendar?.dateByAddingUnit(.Minute, value: -10, toDate: talk.startTime, options: NSCalendarOptions())
        
        if fireDate!.timeIntervalSinceNow > 0 {
            self.schedule(talk)
            return true
        } else {
            return false
        }
    }
    
    func schedule(talk: Talk) {
        
        let placeName = talk.place?.name ?? ""
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let fireDate =  calendar?.dateByAddingUnit(.Minute, value: -10, toDate: talk.startTime, options: NSCalendarOptions())
        let userInfo = ["type" : "Talk", "id" : talk.id] as [NSObject : AnyObject]
        
        let notificaiton = UILocalNotification()
        notificaiton.fireDate = fireDate
        notificaiton.timeZone = NSTimeZone.systemTimeZone()
        notificaiton.alertBody = "10分後に \"" + talk.title + "\" が開始します。" + placeName
        notificaiton.userInfo = userInfo
        
        UIApplication.sharedApplication().scheduleLocalNotification(notificaiton)
        
    }
    
    func cancelSchedule(talk: Talk) {
        if let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications {
           localNotifications.forEach({ (notification) -> () in
            if let userInfo = notification.userInfo {
                if userInfo["id"] as! Int == talk.id {
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                }
            }
           })
        }
    }
    
}
