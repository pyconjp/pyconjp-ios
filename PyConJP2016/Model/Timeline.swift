//
//  Timeline.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/21.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

struct Timeline {
    let header: String
    var talks: Array<TalkObject>
    
    init(startTime: String, talks: Array<TalkObject>?) {
        self.header = startTime.timeStringByTrimingSecond()
        self.talks = talks ?? [TalkObject]()
    }
    
}
