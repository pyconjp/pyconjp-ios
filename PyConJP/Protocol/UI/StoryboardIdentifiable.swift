//
//  StoryboardIdentifiable.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/01.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation

protocol StoryboardIdentifiable {}

extension StoryboardIdentifiable {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
}
