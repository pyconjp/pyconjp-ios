//
//  ScheduleModelController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleModelController: NSObject, UIPageViewControllerDataSource {

    private let days: Array<PyConJPDate> = PyConJPDate.confarenceDate()
    
    override init() {
        super.init()
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ScheduleListViewController? {
        
        if self.days.isEmpty || index >= days.count {
            return nil
        }
        
        let scheduleListViewController = ScheduleListViewController.build(index, storyboard: storyboard, pyconJPDate: days[index])
        return scheduleListViewController
        
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        guard let viewController = viewController as? ScheduleListViewController, pyconJPDate = viewController.pyconJPDate else { return NSNotFound }
        return days.indexOf(pyconJPDate) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == days.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
}
