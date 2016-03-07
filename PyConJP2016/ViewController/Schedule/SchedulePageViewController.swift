//
//  SchedulePageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class SchedulePageViewController: UIPageViewController {

    var dayNumber: Int = 0
    var childrenViewControllers: Array<ScheduleListViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.grayColor()
        
        let startingViewController: ScheduleListViewController = self.scheduleModelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.dataSource = self.scheduleModelController
        
    }
    
    var _scheduleModelController: ScheduleModelController? = nil
    
    var scheduleModelController: ScheduleModelController{
        if _scheduleModelController == nil {
            _scheduleModelController = ScheduleModelController()
        }
        return _scheduleModelController!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        let scheduleBaseViewController = parent as! ScheduleBaseViewController
        self.delegate = scheduleBaseViewController
        
        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = scheduleBaseViewController
            }
        }
    }
}
