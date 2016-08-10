//
//  BaseTabBarController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/19.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    private var scheduleTabNavigationController: UINavigationController?
    private var moreTabNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ScheduleTab
        let scheduleStoryboard = UIStoryboard(name: "Schedule", bundle: NSBundle.mainBundle())
        self.scheduleTabNavigationController = scheduleStoryboard.instantiateViewControllerWithIdentifier("ScheduleNavigationController") as? UINavigationController
        
        //MoreTab
        let moreStoryboard = UIStoryboard(name: "More", bundle: NSBundle.mainBundle())
        self.moreTabNavigationController = moreStoryboard.instantiateViewControllerWithIdentifier("MoreNavigationController") as? UINavigationController
        
        let viewControllers = [scheduleTabNavigationController!, moreTabNavigationController!] as [UIViewController]
        self.setViewControllers(viewControllers, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
