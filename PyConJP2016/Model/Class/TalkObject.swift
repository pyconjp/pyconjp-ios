//
//  TalkObject.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/11/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import RealmSwift

class TalkObject: Object {
    dynamic var id =  0
    dynamic var title = ""
    dynamic var descriptionText = ""
    dynamic var speakers = ""
    dynamic var date: NSDate?
    dynamic var day = ""
    dynamic var startTime = ""
    dynamic var endTime = ""
    dynamic var periodTime = ""
    dynamic var category = ""
    dynamic var place = ""
    dynamic var language = "ja"
    
    dynamic var favorited = false
    
    convenience init(dictionary: Dictionary<String, AnyObject>) {
        self.init()
        id = dictionary["id"] as? Int ?? 0
        title =  dictionary["title"] as? String ?? ""
        descriptionText = dictionary["description"] as? String ?? ""
        speakers = (dictionary["speakers"] as? [String] ?? []).enumerate().reduce("") {
            $0 + $1.element + ((dictionary["speakers"] as? [String] ?? []).count - 1 == $1.index ? "" : ", ")
        }
        date = NSDate.dateFromString((dictionary["day"] as? String ?? "") + " " + (dictionary["start"] as? String ?? ""))
        day = dictionary["day"] as? String ?? ""
        startTime = dictionary["start"] as? String ?? ""
        endTime = dictionary["end"] as? String ?? ""
        periodTime = (dictionary["start"] as? String ?? "").timeStringByTrimingSecond() + " ~ " + (dictionary["end"] as? String ?? "").timeStringByTrimingSecond()
        category = dictionary["category"] as? String ?? ""
        place = dictionary["rooms"] as? String ?? ""
        language = dictionary["language"] as? String ?? ""
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var languageName: String {
        switch language {
        case "ja":
            return "Japanese"
        case "en":
            return "English"
        default:
            return ""
        }
    }
    
    var placeNumber: String {
        guard let placeNumber = self.place.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).last else { return "" }
        return placeNumber
    }
    
}