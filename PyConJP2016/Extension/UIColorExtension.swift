//
//  UIColorExtension.swift
//  PyConJP2016
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
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
    
}

extension UIColor {
    
    struct PyConJP2016 {
        
        static var red: UIColor { return #colorLiteral(red: 0.9215686275, green: 0.4274509804, blue: 0.6039215686, alpha: 1) }
        
        static var orange: UIColor { return #colorLiteral(red: 0.9450980392, green: 0.6, blue: 0.4588235294, alpha: 1) }
        
        static var lightOrange: UIColor { return #colorLiteral(red: 0.9725490196, green: 0.7529411765, blue: 0.3450980392, alpha: 1) }
        
        static var yellow: UIColor { return #colorLiteral(red: 1, green: 0.8941176471, blue: 0.3725490196, alpha: 1) }
        
        static var lightGreen: UIColor { return #colorLiteral(red: 0.662745098, green: 0.7882352941, blue: 0.3215686275, alpha: 1) }
        
        static var green: UIColor { return #colorLiteral(red: 0.5254901961, green: 0.7843137255, blue: 0.6274509804, alpha: 1) }
        
        static var blue: UIColor { return #colorLiteral(red: 0.5254901961, green: 0.7843137255, blue: 0.6274509804, alpha: 1) }
        
        static var gray: UIColor { return #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1) }

    }
    
    static var twitter: UIColor { return #colorLiteral(red: 0.3333333333, green: 0.6745098039, blue: 0.9333333333, alpha: 1) }
    
    static var facebook: UIColor { return #colorLiteral(red: 0.1921568627, green: 0.3137254902, blue: 0.5882352941, alpha: 1) }
    
}
