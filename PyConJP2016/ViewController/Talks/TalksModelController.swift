//
//  TalksModelController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/21.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksModelController: NSObject, UIPageViewControllerDataSource {
//    var childrenViewControllers: Array<TalksListViewController> = []
    var colorArray: Array<UIColor> = []
   
    override init() {
        super.init()
        // Create the data model.
        colorArray = [UIColor.redColor(), UIColor.purpleColor(), UIColor.yellowColor(), UIColor.whiteColor()]
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> TalksListViewController? {
        if (self.colorArray.count == 0) || (index >= self.colorArray.count) {
            return nil
        }
        
        let talksListViewController = storyboard.instantiateViewControllerWithIdentifier("TalksListViewController") as! TalksListViewController
        talksListViewController.view.backgroundColor = self.colorArray[index]
        return talksListViewController

    }

    func indexOfViewController(viewController: TalksListViewController) -> Int {
        return colorArray.indexOf(viewController.view.backgroundColor!) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! TalksListViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! TalksListViewController)
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
