//
//  TalksAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

protocol TalksAPIType: AlamofireType {
    //    func getTalks(parameter: Dictionary<String, AnyObject>?, successClosure success: (NSDictionary) -> Void, failClosure fail: (NSError) -> Void) -> Void
}

extension TalksAPIType {
    
    var path: String {
        return "talks/list/"
    }
    
    func getTalks(parameter: Dictionary<String, AnyObject>?, successClosure success: ([Talk]) -> Void, failClosure fail: (NSError) -> Void) {
        get(parameter, successClosure: { dictionary in
            let presentations = dictionary["presentations"] as? Array<Dictionary<String, AnyObject>> ?? Array()
            
            let talks = presentations.map({
                Talk(dictionary: $0)
            })
            
            success(talks)
            
            }, failClosure: { error in
                
        })
    }
}
