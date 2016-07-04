//
//  TalkAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

protocol TalkAPIType: AlamofireType {
//    var talks: [Talk] { get set }
//    func getTalksWithParameter(parameter: [String : AnyObject], successClosure success: (NSDictionary) -> Void, failClosure fail: (NSError) -> Void) -> Void
}

extension TalkAPIType {
  func getTalksWithParameter(url: String, parameter: [String : AnyObject], successClosure success: ([Talk]) -> Void, failClosure fail: (NSError) -> Void) {
      getWithParameter(url, parameter: parameter, successClosure: { dictionary in
            guard let result = dictionary["result"]?.boolValue, data = dictionary["data"] as? [NSDictionary] else {
                fatalError()
            }
            
            if result {
                var array = [Talk]()
                for talkDictionary in data {
                    let talk = Talk(dictionary: talkDictionary as! [String : AnyObject])
                    array.append(talk)
                }
                
                success(array)
            } else {
                
            }
            
            }, failClosure: { error in
                
        })
    }
}
