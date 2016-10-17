//
//  UIDeviceExtension.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/20/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var modelType: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
    
}
