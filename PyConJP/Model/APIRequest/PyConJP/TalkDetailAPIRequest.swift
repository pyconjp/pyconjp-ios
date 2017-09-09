//
//  TalkDetailAPIRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/12.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import WebAPIFramework

struct TalkDetailAPIRequest: PyConJPRequest {
    
    let id: Int
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "presentation/\(id)/"
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> TalkDetail {
        guard let talkDetail = TalkDetail(object: object) else {
            throw ResponseError.unexpectedObject(object)
        }
        return talkDetail
    }
    
}
