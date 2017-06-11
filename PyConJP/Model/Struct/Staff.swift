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
    
    init?(dictionary: [String: Any]) {
        guard let team = dictionary["team"] as? String,
        let name = dictionary["name"] as? String,
        let role = dictionary["title"] as? String else {
            return nil
        }
        self.init(team: team,
                  name: name,
                  role: role,
                  twitter: dictionary["twitter"] as? String ?? "",
                  facebook: dictionary["facebook"] as? String ?? "")
    }
    
    init?(object: Any) {
        guard let dictionary = object as? [String: Any] else { return nil }
        self.init(dictionary: dictionary)
    }
    
}
