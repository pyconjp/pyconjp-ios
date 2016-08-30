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
    
    static let baseURL = "https://pycon.jp/2016/" + NSLocale.currentLanguageLocaleIdentifier() + "/"
    
    static let apiURL = PCJConfig.baseURL + "api/"
    
}
