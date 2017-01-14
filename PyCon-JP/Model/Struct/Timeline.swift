//
//  Timeline.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/21.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Timeline {
    
    let key: String
    var talks: [TalkObject]
    
}

extension Timeline {
    
    init(time: String, talks: [TalkObject]) {
        self.key = time.timeStringByTrimmingSecond()
        self.talks = talks
    }
    
}
