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
                if let userInfo = notification.userInfo {
                    if let settingId = userInfo["id"] as? Int{
                        if settingId == self.id {
                            self.isSetNotification = true
                        }
                    }
                    
                }
            })
        }
        
    }
    
    init(dictionary: [String : AnyObject]) {
        let id = dictionary["id"] as? Int ?? 0
        let title = dictionary["title"] as? String ?? ""
        let descriptions = dictionary["description"] as? String ?? ""
        let abstract = dictionary["abstract"] as? String ?? ""
        var speaker: Speaker?
        if let speakerDictionary = dictionary["speaker"] as? [String : AnyObject] {
            speaker = Speaker(dictionary: speakerDictionary)
        }
        let startTime = dictionary["start_time"] as! NSDate
        let endTime = dictionary["end_time"] as! NSDate
        let periodTime = Talk.timeToString(startTime) + "~" + Talk.timeToString(endTime)
        var level: Level?
        if let levelDictionary = dictionary["level"] as? [String : AnyObject] {
            level = Level(dictionary: levelDictionary)
        }
        var place: Place?
        if let placeDictionary = dictionary["place"] as? [String : AnyObject] {
            place = Place(dictionary: placeDictionary)
        }
        let language = dictionary["language"] as? String ?? ""
        
        self.init(id: id, title: title, descriptions: descriptions, abstract: abstract, speaker: speaker, startTime: startTime, endTime: endTime, periodTime: periodTime, level: level, place: place, language: language)
    }
    
    //    init(dictionary: [String : AnyObject]) {
    //        id = dictionary["id"] as! Int
    //        title = dictionary["title"] as! String
    //        descriptions = dictionary["description"] as! String
    //        if let speakerDictionary = dictionary["speaker"] as? [String : AnyObject] {
    //            speaker = Speaker(dictionary: speakerDictionary)
    //        } else {
    //            speaker = nil
    //        }
    //        startTime = dictionary["start_time"] as! NSDate
    //        endTime = dictionary["end_time"] as! NSDate
    //        periodTime = Talk.timeToString(startTime) + "~" + Talk.timeToString(endTime)
    //        if let levelDictionary = dictionary["level"] as? [String : AnyObject] {
    //            level = Level(dictionary: levelDictionary)
    //        } else {
    //            level = nil
    //        }
    //        if let placeDictionary = dictionary["place"] as? [String : AnyObject] {
    //            place = Place(dictionary: placeDictionary)
    //        } else {
    //            place = nil
    //        }
    //        language = dictionary["language"] as! String
    //        isSetNotification = false
    //    }
    
    static func timeToString(date: NSDate)-> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day,.Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }
}