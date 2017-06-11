//
//  UIStoryboardExtension.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/01.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.description, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        return self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
    }
    
    enum Storyboard: CustomStringConvertible {
        case main
        case launch
        case events
        case conference
        case bookmark
        case more
        
        var description: String {
            switch self {
            case .main: return "Main"
            case .launch: return "Launch"
            case .events: return "Events"
            case .conference: return "Conference"
            case .bookmark: return "Bookmark"
            case .more: return "More"
            }
        }
        
    }
    
}
