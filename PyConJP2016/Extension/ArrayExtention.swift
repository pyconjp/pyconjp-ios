//
//  ArrayExtention.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/07/22.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

extension Array where Element: Hashable {
    
    func unique() -> [Element] {
        var r = [Element]()
        for i in self {
            r += !r.contains(i) ? [i] : []
        }
        return r
    }
    
    mutating func uniqueInPlace() {
        self = self.unique()
    }
    
}
