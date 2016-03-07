//
//  ScheduleBaseViewController.swift
//  PyConJP2016
//
//  Created by 牟田　裕太郎 on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleBaseViewController: UIViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var barContainerView: UIView!
    @IBOutlet weak var pageContainerView: UIView!
    
    dynamic var offsetToChange: CGFloat = 0.0
    dynamic var displayIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
