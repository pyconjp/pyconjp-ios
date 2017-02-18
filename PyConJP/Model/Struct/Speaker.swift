//
//  Speaker.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Speaker {
    
    let name: String
    let imageURL: String?
    let twitterName: String?
    
}

extension Speaker {
    
    init(dictionary: [String : Any]) {
        name = dictionary["name"] as? String ?? ""
        imageURL = dictionary["image_uri"] as? String
        twitterName = dictionary["twitter"] as? String
    }
        
}
