//
//  ConferenceModelController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceModelController: NSObject, UIPageViewControllerDataSource {
    
    private let days: [PyConJPDate] = PyConJPDate.confarenceDate()
    
    override init() {
        super.init()
    }
    
    func viewController(index: Int) -> ConferenceTimetableViewController? {
        
        if self.days.isEmpty || index >= days.count {
            return nil
        }
        
        let conferenceTimetableViewController = ConferenceTimetableViewController.build(days[index])
        return conferenceTimetableViewController
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        guard let viewController = viewController as? ConferenceTimetableViewController,
            let pyconJPDate = viewController.dataStore?.pyconJPDate else { return NSNotFound }
        return days.index(of: pyconJPDate) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController: viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewController(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController: viewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == days.count {
            return nil
        }
        
        return self.viewController(index: index)
    }
}
