//
//  BaseTabBarController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/19.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    private var eventsTabNavigationController: UINavigationController?
    private var conferenceTabNavigationController: UINavigationController?
    private var moreTabNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // EventsceTab
        let eventsStoryboard = UIStoryboard(name: "Events", bundle: Bundle.main)
        eventsTabNavigationController = eventsStoryboard.instantiateViewController(withIdentifier: "EventsNavigationController") as? UINavigationController
        
        // ConferenceTab
        let conferenceStoryboard = UIStoryboard(name: "Conference", bundle: Bundle.main)
        conferenceTabNavigationController = conferenceStoryboard.instantiateViewController(withIdentifier: "ConferenceNavigationController") as? UINavigationController
        
        // MoreTab
        let moreStoryboard = UIStoryboard(name: "More", bundle: Bundle.main)
        moreTabNavigationController = moreStoryboard.instantiateViewController(withIdentifier: "MoreNavigationController") as? UINavigationController
        
        let viewControllers = [eventsTabNavigationController!, conferenceTabNavigationController!, moreTabNavigationController!] as [UIViewController]
        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = 1
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
