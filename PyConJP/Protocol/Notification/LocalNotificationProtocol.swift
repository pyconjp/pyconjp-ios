//
//  LocalNotificationProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 3/13/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol LocalNotificationProtocol {}

extension LocalNotificationProtocol {
    
    func makeNotification(talkDetail: TalkDetail) -> Bool {
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        guard let date = calendar.date(byAdding: .minute, value: -10, to: talkDetail.talkObject.startDate),
            date.timeIntervalSinceNow > 0 else { return false }
        
        self.schedule(talkDetail: talkDetail, at: date)
        return true
    }
    
    private func schedule(talkDetail: TalkDetail, at date: Date) {
        
        let userInfo = ["type": "Talk", "id": talkDetail.talkObject.id] as [AnyHashable: Any]
        
        let notificaiton = UILocalNotification()
        notificaiton.fireDate = date
        notificaiton.timeZone = TimeZone.current
        notificaiton.alertBody = "10分後に \" \(talkDetail.talkObject.title) \" が開始します。 \(talkDetail.talkObject.room?.description ?? "")"
        notificaiton.userInfo = userInfo
        
        UIApplication.shared.scheduleLocalNotification(notificaiton)
        
    }
    
    func cancelSchedule(talkDetail: TalkDetail) {
        if let localNotifications = UIApplication.shared.scheduledLocalNotifications {
            localNotifications.forEach({ notification in
                if let userInfo = notification.userInfo {
                    if userInfo["id"] as! Int == talkDetail.talkObject.id {
                        UIApplication.shared.cancelLocalNotification(notification)
                    }
                }
            })
        }
    }
    
}
