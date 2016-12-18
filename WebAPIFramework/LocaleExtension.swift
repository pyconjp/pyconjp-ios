//
//  NSLocaleExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/16/2016.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension Locale {
    
    static var currentLanguageLocaleIdentifier: String {
        return Bundle.main.preferredLocalizations.first!
    }
    
    static var currentLanguageLocale: Locale {
        return Locale(identifier: Locale.currentLanguageLocaleIdentifier)
    }
    
}
