//
//  GitHubRequest.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/09/02.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import APIKit

public protocol GitHubRequest: Request {}

public extension GitHubRequest {
    
    public var baseURL: URL {
        return URL(string: "https://pyconjp.github.io/app-static-api/2017/" + Locale.currentLanguageLocaleIdentifier + "/")!
    }
    
}
