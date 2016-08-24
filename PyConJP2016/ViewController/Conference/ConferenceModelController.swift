//
//  ConferenceModelController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceModelController: NSObject, UIPageViewControllerDataSource {
    
    private let days: Array<PyConJPDate> = PyConJPDate.confarenceDate()
    
    override init() {
        super.init()
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ConferenceListViewController? {
        
        if self.days.isEmpty || index >= days.count {
            return nil
        }
        
        let conferenceListViewController = ConferenceListViewController.build(index, storyboard: storyboard, pyconJPDate: days[index])
        return conferenceListViewController
        
    }
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        guard let viewController = viewController as? ConferenceListViewController, pyconJPDate = viewController.pyconJPDate else { return NSNotFound }
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
