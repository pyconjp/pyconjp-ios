//
//  TalkDetailAPIProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 7/25/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework

protocol TalkDetailAPIProtocol: AlamofireProtocol {
    var id: Int? { get set }
    
    func getTalkDetail(completionHandler: @escaping ((Result<TalkDetail>) -> Void)) -> Void
}

extension TalkDetailAPIProtocol {
    
    var path: String {
        guard let id = id else { return "" }
        return "presentation/\(id)/"
    }
    
}

extension TalkDetailAPIProtocol {
    
    func getTalkDetail(completionHandler: @escaping ((Result<TalkDetail>) -> Void)) -> Void {
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
    
}
