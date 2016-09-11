//
//  PCJConfig.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/30/2016.
//  Copyright © 2016 PyCon JP. All rights reserved.
//
//

import UIKit

enum PCJConfig {
    
    static let hostURL = NSProcessInfo.processInfo().environment["APIBaseURL"] ?? "https://pycon.jp"
    
    static let baseURL = PCJConfig.hostURL + "/2016/" + NSLocale.currentLanguageLocaleIdentifier + "/"
    
    static let apiURL = PCJConfig.baseURL + "api/"
    
    static let authUser = NSProcessInfo.processInfo().environment["APIAuthUser"] ?? ""
    
    static let authPassword = NSProcessInfo.processInfo().environment["APIAuthPassword"] ?? ""
    
}
