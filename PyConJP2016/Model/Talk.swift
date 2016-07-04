//
//  TalkModel.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

struct Talk {
    
    let id: Int
    let title: String
    let descriptions: String
    let abstract: String
    let speaker: Speaker?
    let startTime: NSDate
    let endTime: NSDate
    let periodTime: String
    let level: Level?
    let place: Place?
    let language: String
    var isSetNotification: Bool = false
    
}

extension Talk {
    
    init(id: Int, title: String, descriptions: String, abstract: String, speaker: Speaker?, startTime: NSDate, endTime: NSDate, periodTime: String, level: Level?, place: Place?, language: String) {
        self.id = id
        self.title = title
        self.descriptions = descriptions
        self.abstract = abstract
        self.speaker = speaker
        self.startTime = startTime
        self.endTime = endTime
        self.periodTime = periodTime
        self.level = level
        self.place = place
        self.language = language
        
        if let notifications = UIApplication.sharedApplication().scheduledLocalNotifications {
            notifications.forEach({ (notification) -> () in
                if let settingId = notification.userInfo?["id"] as? Int where settingId == self.id {
                    self.isSetNotification = true
                }
            })
        }
    }
    
    init(dictionary: [String : AnyObject]) {
        self.init(id: dictionary["id"] as? Int ?? 0,
                  title: dictionary["title"] as? String ?? "",
                  descriptions: dictionary["description"] as? String ?? "",
                  abstract: dictionary["abstract"] as? String ?? "",
                  speaker: Speaker(dictionary: dictionary["speaker"] as? [String: AnyObject]),
                  startTime: dictionary["start_time"] as! NSDate,
                  endTime: dictionary["end_time"] as! NSDate,
                  periodTime: Talk.timeToString(dictionary["start_time"] as! NSDate) + "~" + Talk.timeToString(dictionary["end_time"] as! NSDate),
                  level: Level(dictionary: dictionary["level"] as? [String: AnyObject]),
                  place: Place(dictionary: dictionary["place"] as? [String: AnyObject]),
                  language: dictionary["language"] as? String ?? "")
    }
    
    static func timeToString(date: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }
}
