//
//  PlaceModel.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class PlaceModel: NSObject {
    
    var id: Int = 0
    var name: String = ""
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
    }

}

struct Place {
    
    var id: Int = 0
    var name: String = ""
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
    }
    
}
