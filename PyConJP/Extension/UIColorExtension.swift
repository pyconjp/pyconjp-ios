//
//  UIColorExtension.swift
//  PyConJP
//
//  Created by Yutaro Muta on 4/23/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hex(string: NSString, alpha: CGFloat) -> UIColor {
        let hex = string.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
    
}

extension UIColor {
    
    struct PyConJP2017 {
        
        static var navy: UIColor { return #colorLiteral(red: 0.1098039216, green: 0.4274509804, blue: 0.6235294118, alpha: 1) }
        
        static var yellow: UIColor { return #colorLiteral(red: 0.8862745098, green: 0.6666666667, blue: 0.07843137255, alpha: 1) }
        
        static var red: UIColor { return #colorLiteral(red: 0.8392156863, green: 0, blue: 0.2274509804, alpha: 1) }
        
        static var gray: UIColor { return #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1) }
        
        static var favorite: UIColor { return #colorLiteral(red: 1, green: 1, blue: 0.5987487964, alpha: 1) }
        
    }
    
    static var twitter: UIColor { return #colorLiteral(red: 0.3333333333, green: 0.6745098039, blue: 0.9333333333, alpha: 1) }
    
    static var facebook: UIColor { return #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.5882352941, alpha: 1) }
    
}
