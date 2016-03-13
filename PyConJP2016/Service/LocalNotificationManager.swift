//
//  LocalNotificationManager.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/13/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class LocalNotificationManager: NSObject {
    
    func makeNotification(talk: Talk, userInfo: [NSObject : AnyObject]) -> Bool {
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let fireDate = calendar?.dateByAddingUnit(.Minute, value: -10, toDate: talk.startTime, options: NSCalendarOptions())
        
        if fireDate!.timeIntervalSinceNow > 0 {
            self.schedule(talk, userInfo: userInfo)
            return true
        } else {
            return false
        }
    }
    
    func schedule(talk: Talk, userInfo: [NSObject : AnyObject]) {
        
        let placeName = talk.place?.name ?? ""
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let fireDate =  calendar?.dateByAddingUnit(.Minute, value: -10, toDate: talk.startTime, options: NSCalendarOptions())
        
        let notificaiton = UILocalNotification()
        notificaiton.fireDate = fireDate
        notificaiton.timeZone = NSTimeZone.systemTimeZone()
        notificaiton.alertBody = "10分後に" + talk.title + "が開始します。" + placeName
        notificaiton.userInfo = userInfo
        
        UIApplication.sharedApplication().scheduleLocalNotification(notificaiton)
        
    }
    
}
