//
//  TalkDetail.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

struct TalkDetail {
    
    var talkObject: TalkObject
    let abstract: String
    let level: String
    
}

extension TalkDetail {
    
    init(dictionary: Dictionary<String, AnyObject>) {
        self.init(talkObject: TalkObject(dictionary: dictionary),
                  abstract: dictionary["abstract"] as? String ?? "",
                  level: dictionary["level"] as? String ?? "")
    }
    
}

//struct TalkDetail {
//    
//    let id: Int
//    let title: String
//    let description: String
//    let abstract: String
//    let speakers: [String]?
//    let date: NSDate?
//    let day: String
//    let startTime: String
//    let endTime: String
//    let periodTime: String
//    let category: String
//    let level: String
//    let place: String
//    let language: Language
//    var isSetNotification: Bool = false
//    
//}
//
//extension TalkDetail {
//    
//    init(id: Int, title: String, description: String, abstract: String, speakers: [String]?, day: String, startTime: String, endTime: String, category: String, level: String, place: String, language: String) {
//        self.id = id
//        self.title = title
//        self.description = description
//        self.abstract = abstract
//        self.speakers = speakers
//        self.date = NSDate.dateFromString(day + " " + startTime)
//        self.day = day
//        self.startTime = startTime
//        self.endTime = endTime
//        self.periodTime = startTime.timeStringByTrimingSecond() + " ~ " + endTime.timeStringByTrimingSecond()
//        self.category = category
//        self.level = level
//        self.place = place
//        self.language = Language(rawValue: language) ?? .JA
//        
//        if let notifications = UIApplication.sharedApplication().scheduledLocalNotifications {
//            notifications.forEach({ (notification) -> () in
//                if let settingId = notification.userInfo?["id"] as? Int where settingId == self.id {
//                    self.isSetNotification = true
//                }
//            })
//        }
//    }
//    
//    init(dictionary: Dictionary<String, AnyObject>) {
//        self.init(id: dictionary["id"] as? Int ?? 0,
//                  title: dictionary["title"] as? String ?? "",
//                  description: dictionary["description"] as? String ?? "",
//                  abstract: dictionary["abstract"] as? String ?? "",
//                  speakers: dictionary["speakers"] as? [String],
//                  day: dictionary["day"] as? String ?? "",
//                  startTime: dictionary["start"] as? String ?? "",
//                  endTime: dictionary["end"] as? String ?? "",
//                  category: dictionary["category"] as? String ?? "",
//                  level: dictionary["level"] as? String ?? "",
//                  place: dictionary["rooms"] as? String ?? "",
//                  language: dictionary["language"] as? String ?? "")
//    }
//    
//}
