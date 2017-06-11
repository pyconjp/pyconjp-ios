//
//  StaffListAPIRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/12.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit

struct StaffListAPIRequest: Request {
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseURL: URL {
        return URL(string: "https://pyconjp.github.io/")!
    }
    
    var path: String {
        return "pyconjp-android/stafflist.json"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Staff] {
        guard let dictionary = object as? [String: Any],
            let staffList = dictionary["staffList"] as? [Any] else {
                throw ResponseError.unexpectedObject(object)
        }
        return staffList.flatMap({ Staff(object: $0) })
    }
    
}
