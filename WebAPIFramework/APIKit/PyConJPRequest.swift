//
//  PyConJPRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/12.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit

public protocol PyConJPRequest: Request {}

public extension PyConJPRequest {
    
    public var baseURL: URL {
        return URL(string: WebConfig.apiURL)!
    }
    
}
