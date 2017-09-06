//
//  DummyTalksProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/14.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import Result

protocol DummyTalksProtocol {
    
    func getTalksFromLocalDummyJSON(completionHandler: ((Result<[TalkObject], NSError>) -> Void))
    
}

extension DummyTalksProtocol {
    
    func getTalksFromLocalDummyJSON(completionHandler: ((Result<[TalkObject], NSError>) -> Void)) {
        let path = Bundle.main.path(forResource: "DummyTalks", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
        let presentations = dictionary["presentations"] as? [[String: Any]] ?? [[String: Any]]()
        
        completionHandler(.success(presentations.flatMap({ TalkObject(object: $0) })))
        
    }
    
}
