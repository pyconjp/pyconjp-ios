//
//  PCJConfig.swift
//  PyConJP
//
//  Created by Yutaro Muta on 8/30/2016.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import Foundation

public enum WebConfig {
    
    public static let hostURL = ProcessInfo.processInfo.environment["APIBaseURL"] ?? "https://pycon.jp"
    
    public static let baseURL = WebConfig.hostURL + "/2016/" + Locale.currentLanguageLocaleIdentifier + "/"
    
    static let apiURL = WebConfig.baseURL + "api/"
    
    static let authUser = ProcessInfo.processInfo.environment["APIAuthUser"] ?? ""
    
    static let authPassword = ProcessInfo.processInfo.environment["APIAuthPassword"] ?? ""
    
}
