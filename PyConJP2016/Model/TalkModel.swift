//
//  TalkModel.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalkModel: NSObject {
    var id: Int = 0
    var title: String = ""
    var descriptions: String = ""
    var speaker: SpeakerModel?
    var startTime: NSDate = NSDate()
    var endTime: NSDate = NSDate()
    var periodTime: String = ""
    var level: LevelModel?
    var place: PlaceModel?
    var language: String = ""
    var isSetNotification: Bool = false
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as! Int
        title = dictionary["title"] as! String
        descriptions = dictionary["description"] as! String
        if let speakerDictionary = dictionary["speaker"] as? [String : AnyObject] {
            speaker = SpeakerModel(dictionary: speakerDictionary)
        }
        startTime = dictionary["start_time"] as! NSDate
        endTime = dictionary["end_time"] as! NSDate
//        periodTime = self.timeToString(startTime) + "~" + self.timeToString(endTime)
        if let levelDictionary = dictionary["level"] as? [String : AnyObject] {
            level = LevelModel(dictionary: levelDictionary)
        }
        if let placeDictionary = dictionary["place"] as? [String : AnyObject] {
            place = PlaceModel(dictionary: placeDictionary)
        }
        language = dictionary["language"] as! String
    }
    
    func createPeriodTime() -> String {
        return self.timeToString(startTime) + "~" + self.timeToString(endTime)
    }
    
    func timeToString(date: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day,.Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }
}

struct Talk {
    var id: Int = 0
    var title: String = ""
    var descriptions: String = ""
    var speaker: Speaker?
    var startTime: NSDate = NSDate()
    var endTime: NSDate = NSDate()
    var periodTime: String = ""
    var level: Level?
    var place: Place?
    var language: String = ""
    var isSetNotification: Bool = false
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as! Int
        title = dictionary["title"] as! String
        descriptions = dictionary["description"] as! String
        if let speakerDictionary = dictionary["speaker"] as? [String : AnyObject] {
            speaker = Speaker(dictionary: speakerDictionary)
        }
        startTime = dictionary["start_time"] as! NSDate
        endTime = dictionary["end_time"] as! NSDate
        periodTime = self.timeToString(startTime) + "~" + self.timeToString(endTime)
        if let levelDictionary = dictionary["level"] as? [String : AnyObject] {
            level = Level(dictionary: levelDictionary)
        }
        if let placeDictionary = dictionary["place"] as? [String : AnyObject] {
            place = Place(dictionary: placeDictionary)
        }
        language = dictionary["language"] as! String
    }
    
    func timeToString(date: NSDate)-> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender?.components([.Year, .Month, .Day,.Weekday, .Hour, .Minute], fromDate: date)
        return "\(components?.hour):\(components?.minute)"
    }
}