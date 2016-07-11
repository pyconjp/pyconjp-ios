//
//  Talk.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

struct Talk {
    
    let id: Int
    let title: String
    let description: String
    let speakers: [String]?
    let days: String
    let startTime: NSDate
    let endTime: NSDate
    let periodTime: String
    let category: String
    let place: String
    let language: Language
    
}

extension Talk {
    
    init(id: Int, title: String, description: String, speakers: [String]?, day: String, startTime: NSDate, endTime: NSDate, periodTime: String, category: String, place: String, language: String) {
        self.id = id
        self.title = title
        self.description = description
        self.speakers = speakers
        self.days = day
        self.startTime = startTime
        self.endTime = endTime
        self.periodTime = periodTime
        self.category = category
        self.place = place
        self.language = Language(rawValue: language) ?? .JA
    }
    
    init(dictionary: [String : AnyObject]) {
        self.init(id: dictionary["id"] as? Int ?? 0,
                  title: dictionary["title"] as? String ?? "",
                  description: dictionary["description"] as? String ?? "",
                  speakers: dictionary["speakers"] as? [String],
                  day: dictionary["day"] as? String ?? "",
                  startTime: dictionary["start"] as! NSDate,
                  endTime: dictionary["end"] as! NSDate,
                  periodTime: TalkDetail.timeToString(dictionary["start"] as! NSDate) + "~" + TalkDetail.timeToString(dictionary["end"] as! NSDate),
                  category: dictionary["category"] as? String ?? "",
                  place: dictionary["rooms"] as? String ?? "",
                  language: dictionary["language"] as? String ?? "")
    }
    
    static func timeToString(date: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }
}
