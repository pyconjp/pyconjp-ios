//
//  TalkDetailAPIType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/25/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

protocol TalkDetailAPIType: AlamofireType {
    var id: Int? { get set }
    
    func getTalkDetail(successClosure success: @escaping (TalkDetail) -> Void, failClosure fail: @escaping (Error) -> Void) -> Void
    func getTalkDetail(_ completionHandler: @escaping ((Result<TalkDetail>) -> Void)) -> Void
    func getTalkDetailFromLocalDummyJson(_ completionHandler: ((Result<TalkDetail>) -> Void)) -> Void
}

extension TalkDetailAPIType {
    
    var path: String {
        guard let id = id else { return "" }
        return "presentation/\(id)/"
    }
    
}

extension TalkDetailAPIType {
    
    func getTalkDetail(successClosure success: @escaping (TalkDetail) -> Void, failClosure fail: @escaping (Error) -> Void) -> Void {
        get(successClosure: { dictionary in
            let talkDetail = TalkDetail(dictionary: dictionary)
            success(talkDetail)
            }, failClosure: { error in
                fail(error)
        })
    }
    
    func getTalkDetail(_ completionHandler: @escaping ((Result<TalkDetail>) -> Void)) -> Void {
        get() { result in
            switch result {
            case .success(let value):
                let talkDetail = TalkDetail(dictionary: value)
                completionHandler(.success(talkDetail))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getTalkDetailFromLocalDummyJson(_ completionHandler: ((Result<TalkDetail>) -> Void)) -> Void {
        let path = Bundle.main.path(forResource: "DummyTalkDetail", ofType: "json")
        let fileHandle = FileHandle(forReadingAtPath: path!)
        let data = fileHandle?.readDataToEndOfFile()
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, AnyObject>
        
        let talkDetail = TalkDetail(dictionary: dictionary)
        completionHandler(.success(talkDetail))
        
    }
    
}
