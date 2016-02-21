//
//  SpeakerModel.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class SpeakerModel: NSObject {
    
    var id: Int = 0
    var name: String = ""
    var imageURL: String = ""
    var twitterName: String = ""
    var githubName: String = ""
    
    init(dictionary : [String : AnyObject]) {
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
        imageURL = dictionary["image_url"] as! String
        twitterName = dictionary["twitter_name"] as! String
        githubName = dictionary["github_name"] as! String
    }
    
}
