//
//  PCJConfig.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/30/2016.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

enum PCJConfig {
    
    static let hostURL = ProcessInfo.processInfo.environment["APIBaseURL"] ?? "https://pycon.jp"
    
    static let baseURL = PCJConfig.hostURL + "/2016/" + Locale.currentLanguageLocaleIdentifier + "/"
    
    static let apiURL = PCJConfig.baseURL + "api/"
    
    static let authUser = ProcessInfo.processInfo.environment["APIAuthUser"] ?? ""
    
    static let authPassword = ProcessInfo.processInfo.environment["APIAuthPassword"] ?? ""
    
    static let mailAddress = "symposion@pycon.jp"
    
}
