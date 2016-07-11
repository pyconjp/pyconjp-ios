//
//  TalkDetail.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

struct TalkDetail {
    
    let id: Int
    let title: String
    let description: String
    let abstract: String
    let speakers: [String]?
    let startTime: NSDate
    let endTime: NSDate
    let periodTime: String
    let category: String
    let level: String
    let place: String
    let language: Language
    var isSetNotification: Bool = false
    
}

extension TalkDetail {
    
    init(id: Int, title: String, description: String, abstract: String, speakers: [String]?, startTime: NSDate, endTime: NSDate, periodTime: String, category: String, level: String, place: String, language: String) {
        self.id = id
        self.title = title
        self.description = description
        self.abstract = abstract
        self.speakers = speakers
        self.startTime = startTime
        self.endTime = endTime
        self.periodTime = periodTime
        self.category = category
        self.level = level
        self.place = place
        self.language = Language.convert(language)
        
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
                  description: dictionary["description"] as? String ?? "",
                  abstract: dictionary["abstract"] as? String ?? "",
                  speakers: dictionary["speakers"] as? [String],
                  startTime: dictionary["start"] as! NSDate,
                  endTime: dictionary["end"] as! NSDate,
                  periodTime: TalkDetail.timeToString(dictionary["start"] as! NSDate) + "~" + TalkDetail.timeToString(dictionary["end"] as! NSDate),
                  category: dictionary["category"] as? String ?? "",
                  level: dictionary["level"] as? String ?? "",
                  place: dictionary["rooms"] as? String ?? "",
                  language: dictionary["language"] as? String ?? "")
    }
    
    static func timeToString(date: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }
}
