//
//  TalkDetail.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

struct TalkDetail {
    
    var talkObject: TalkObject
    let speakers: [Speaker]
    let abstract: String
    let level: String
    
}

extension TalkDetail {
    
    init?(dictionary: [String: Any]) {
        guard let talkObject = TalkObject(dictionary: dictionary),
            let abstract = dictionary["abstract"] as? String,
            let level = dictionary["level"] as? String else { return nil }
        self.init(talkObject: talkObject,
                  speakers: (dictionary["speaker_infomations"] as? [[String: Any]] ?? []).map({ Speaker(dictionary: $0) }),
                  abstract: abstract,
                  level: level)
    }

    init?(object: Any) {
        guard let dictionary = object as? [String: Any] else { return nil}
        self.init(dictionary: dictionary)
    }
    
}
