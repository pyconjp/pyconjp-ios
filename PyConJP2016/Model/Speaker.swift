//
//  SpeakerModel.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

struct Speaker {
    
    let id: Int
    let name: String
    let imageURL: String
    let twitterName: String
    let githubName: String
    
}

extension Speaker {
    
    init(dictionary : [String : AnyObject]) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        imageURL = dictionary["image_url"] as? String ?? ""
        twitterName = dictionary["twitter"] as? String ?? ""
        githubName = dictionary["github"] as? String ?? ""
    }
    
}
