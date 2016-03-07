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
    var colorArray: Array<UIColor> = []
    
    override init() {
        super.init()
        // Create the data model.
        colorArray = [UIColor.redColor(), UIColor.purpleColor()]
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ScheduleListViewController? {
        if (self.colorArray.count == 0) || (index >= self.colorArray.count) {
            return nil
        }
        
        let scheduleListViewController = storyboard.instantiateViewControllerWithIdentifier("ScheduleListViewController") as! ScheduleListViewController
        scheduleListViewController.view.backgroundColor = self.colorArray[index]
        scheduleListViewController.viewControllerIndex = index
        return scheduleListViewController
        
    }
    
    func indexOfViewController(viewController: ScheduleListViewController) -> Int {
        return colorArray.indexOf(viewController.view.backgroundColor!) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ScheduleListViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ScheduleListViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.colorArray.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
}
