//
//  Speaker.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

struct Speaker {
    
    let name: String
    let imageURL: String?
    let twitterAccount: String?
    
}

extension Speaker {
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String ?? ""
        imageURL = dictionary["image_uri"] as? String
        twitterAccount = dictionary["twitter"] as? String
    }
        
}
