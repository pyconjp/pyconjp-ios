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
    var startTime: String = ""
    var endTime: String = ""
    var level: LevelModel?
    var place: PlaceModel?
    var language: String = ""
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as! Int
        title = dictionary["title"] as! String
        descriptions = dictionary["description"] as! String
        if let speakerDictionary = dictionary["speaker"] as? [String : AnyObject] {
            speaker = SpeakerModel(dictionary: speakerDictionary)
        }
        startTime = dictionary["start_time"] as! String
        endTime = dictionary["end_time"] as! String
        if let levelDictionary = dictionary["level"] as? [String : AnyObject] {
            level = LevelModel(dictionary: levelDictionary)
        }
        if let placeDictionary = dictionary["place"] as? [String : AnyObject] {
            place = PlaceModel(dictionary: placeDictionary)
        }
        language = dictionary["language"] as! String
    }
    
}
