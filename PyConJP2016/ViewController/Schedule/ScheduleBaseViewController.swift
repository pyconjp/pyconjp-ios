//
//  ScheduleBaseViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleBaseViewController: UIViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var barContainerView: UIView!
    @IBOutlet weak var pageContainerView: UIView!
    
    var scheduleDateViewProtocol: ScheduleDateViewProtocol?
    var schedulePageViewProtocol: SchedulePageViewProtocol?
    
    private var offsetToChange: CGFloat = 0.0 {
        didSet {
            
        }
    }
    
    private var displayIndex: Int = 0 {
        didSet {
            if let scheduleDateViewProtocol = scheduleDateViewProtocol {
            	scheduleDateViewProtocol.changeActive(displayIndex)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let schedulePageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SchedulePageViewController")
        schedulePageViewController?.view.frame = pageContainerView.bounds
        self.addChildViewController(schedulePageViewController!)
        pageContainerView.addSubview(schedulePageViewController!.view)
        schedulePageViewController?.didMoveToParentViewController(self)
        
        let scheduleDateViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ScheduleDateViewController")
        scheduleDateViewController?.view.frame = barContainerView.bounds
        self.addChildViewController(scheduleDateViewController!)
        barContainerView.addSubview(scheduleDateViewController!.view)
        scheduleDateViewController?.didMoveToParentViewController(self)

    }
    
    override func viewDidAppear(animated: Bool) {
//        offsetToChange = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let displayViewController = pageViewController.viewControllers?.last as! ScheduleListViewController
        displayIndex = displayViewController.viewControllerIndex
        //        if 1 - barContainerView.frame.origin.x < 1 {
        //
        //        } else if 1 - (barContainerView.frame.size.width / 2) < 1 {
        //
        //        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x - pageContainerView.frame.size.width != 0 {
            offsetToChange = scrollView.contentOffset.x - pageContainerView.frame.size.width
        }
    }

}

protocol SchedulePageViewProtocol {
    func fowardPage(index: Int)
    func reversePage(index: Int)
}

protocol ScheduleDateViewProtocol {
    func changeActive(index: Int)
}
