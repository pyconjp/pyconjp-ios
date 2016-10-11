//
//  Category.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/04/27.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Category {
    
    let id: Int
    let name: String
    
}

extension Category {
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
}
