//
//  Level.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Level {
    
    let id: Int
    let name: String
    
}

extension Level {
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
    init?(dictionary: [String : AnyObject]?) {
        guard let dictionary = dictionary else { return nil }
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
}
