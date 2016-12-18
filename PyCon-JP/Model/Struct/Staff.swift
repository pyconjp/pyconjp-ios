//
//  Staff.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/10/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

struct Staff {
    
    let team: String
    let name: String
    let role: String
    let twitter: String
    let facebook: String
    
}

extension Staff {
    
    init(dictionary: Dictionary<String, AnyObject>) {
        self.init(team: dictionary["team"] as? String ?? "",
                  name: dictionary["name"] as? String ?? "",
                  role: dictionary["title"] as? String ?? "",
                  twitter: dictionary["twitter"] as? String ?? "",
                  facebook: dictionary["facebook"] as? String ?? "")
    }
    
}
