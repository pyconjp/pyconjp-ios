//
//  TalksAPIRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/12.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import WebAPIFramework

struct TalksAPIRequest: PyConJPRequest {
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "talks/list/"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [TalkObject] {
        guard let dictionary = object as? [String: Any],
        let presentations = dictionary["presentations"] as? [Any] else {
            throw ResponseError.unexpectedObject(object)
        }
        return presentations.flatMap({ TalkObject(object: $0) })
    }
    
}
