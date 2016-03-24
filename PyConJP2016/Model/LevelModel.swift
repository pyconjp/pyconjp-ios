//
//  LevelModel.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

//class LevelModel: NSObject {
//    
//    var id: Int = 0
//    var name: String = ""
//    
//    init(dictionary: [String : AnyObject]) {
//        id = dictionary["id"] as! Int
//        name = dictionary["name"] as! String
//    }
//    
//}

struct Level {
    
    let id: Int
    let name: String
    
    init(dictionary: [String : AnyObject]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
    
}
