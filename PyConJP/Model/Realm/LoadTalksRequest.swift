//
//  LoadTalksRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/16.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import RealmSwift

struct LoadTalksRequest: RealmLoadTalksProtocol {
    
    let filterPredicate: NSPredicate
    let sortProperties = [SortDescriptor(keyPath: "startDate", ascending: true),
                          SortDescriptor(keyPath: "roomString", ascending: true)]
    
    init(day: String?) {
        self.filterPredicate = NSPredicate(format: "day == %@", day ?? "")
    }
    
}
