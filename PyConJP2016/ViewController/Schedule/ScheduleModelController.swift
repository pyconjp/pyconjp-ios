//
//  ScheduleModelController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleModelController: NSObject, UIPageViewControllerDataSource {
    //    var childrenViewControllers: Array<ScheduleListViewController> = []
    let days: Array<String> = ["2016-09-21", "2016-09-22"]
    
    override init() {
        super.init()
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ScheduleListViewController? {
        
        if self.days.isEmpty || index >= days.count {
            return nil
        }
        
        let scheduleListViewController = storyboard.instantiateViewControllerWithIdentifier("ScheduleListViewController") as! ScheduleListViewController
        scheduleListViewController.day = days[index]
        scheduleListViewController.viewControllerIndex = index
        return scheduleListViewController
        
    }
    
    func indexOfViewController(viewController: ScheduleListViewController) -> Int {
        return days.indexOf(viewController.day) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ScheduleListViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ScheduleListViewController)
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
