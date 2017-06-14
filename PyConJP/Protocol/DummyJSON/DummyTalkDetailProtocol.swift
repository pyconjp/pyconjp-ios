//
//  DummyTalkDetailProtocol.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/12/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation
import Result

protocol DummyTalkDetailProtocol {
    
    func getTalksFromLocalDummyJSON(completionHandler: ((Result<TalkDetail, NSError>) -> Void))
    
}

extension DummyTalkDetailProtocol {
    
    func getTalkDetailFromLocalDummyJSON(completionHandler: ((Result<TalkDetail, NSError>) -> Void)) {
        let path = Bundle.main.path(forResource: "DummyTalkDetail", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            
            let talkDetail = TalkDetail(dictionary: dictionary)!
            completionHandler(.success(talkDetail))
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
        
    }
    
}
