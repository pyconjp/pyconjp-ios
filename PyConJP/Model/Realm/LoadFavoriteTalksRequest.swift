//
//  LoadFavoriteTalksRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/16.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import RealmSwift

struct LoadFavoriteTalksRequest: RealmLoadTalksProtocol {
    
    let filterPredicate = NSPredicate(format: "isFavorite == %@", true as CVarArg)
    let sortProperties = [SortDescriptor(keyPath: "startDate", ascending: true),
                          SortDescriptor(keyPath: "roomString", ascending: true)]
    
}
