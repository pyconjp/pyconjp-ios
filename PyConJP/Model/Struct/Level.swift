//
//  Level.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

struct Level {
    
    let id: Int
    let name: String
    
}

extension Level {
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
    init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return nil }
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
}
