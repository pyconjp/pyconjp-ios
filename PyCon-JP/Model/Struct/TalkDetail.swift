//
//  TalkDetail.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct TalkDetail {
    
    var talkObject: TalkObject
    let speakers: Array<Speaker>
    let abstract: String
    let level: String
    
}

extension TalkDetail {
    
    init(dictionary: Dictionary<String, Any>) {
        self.init(talkObject: TalkObject(dictionary: dictionary),
                  speakers: (dictionary["speaker_infomations"] as? [Dictionary<String, Any>] ?? []).map({ Speaker.init(dictionary: $0) }),
                  abstract: dictionary["abstract"] as? String ?? "",
                  level: dictionary["level"] as? String ?? "")
    }

}
