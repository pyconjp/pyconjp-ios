//
//  SurveyURLAPIRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/09/05.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit
import WebAPIFramework

struct SurveyURLAPIRequest: GitHubRequest {
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "surveyURL.json"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> URL {
        guard let dictionary =  object as? [String: Any],
            let urlString = dictionary["url"] as? String,
            let url = URL(string: urlString) else {
            throw ResponseError.unexpectedObject(object)
        }
        return url
    }
    
}
