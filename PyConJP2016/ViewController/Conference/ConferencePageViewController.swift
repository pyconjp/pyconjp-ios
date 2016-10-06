//
//  ConferencePageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferencePageViewController: UIPageViewController, ConferencePageViewProtocol, ErrorAlertType {
    
    fileprivate var conferenceModelViewProtocol: ConferenceModelViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startingViewController = self.conferenceModelController.viewController(index: 0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        
        self.dataSource = self.conferenceModelController
        
    }
    
    fileprivate var _conferenceModelController: ConferenceModelController? = nil
    
    fileprivate var conferenceModelController: ConferenceModelController {
        if _conferenceModelController == nil {
            _conferenceModelController = ConferenceModelController()
        }
        return _conferenceModelController!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        let conferenceBaseViewController = parent as! ConferenceBaseViewController
        self.delegate = conferenceBaseViewController
        conferenceBaseViewController.conferencePageViewProtocol = self
        
        self.view.subviews.forEach {
            if let scrollView = $0 as? UIScrollView {
                scrollView.delegate = conferenceBaseViewController
            }
        }
    }
    
    // MARK: - ConferencePageViewProtocol
    
    func fowardPage(index: Int) {
        self.movePage(index: index, direction: .forward)
    }
    
    func reversePage(index: Int) {
        self.movePage(index: index, direction: .reverse)
    }
    
    fileprivate func movePage(index: Int, direction: UIPageViewControllerNavigationDirection) {
        let viewController = conferenceModelController.viewController(index: index, storyboard: self.storyboard!)!
        let viewControllers = [viewController]
        self.setViewControllers(viewControllers, direction: direction, animated: true, completion: {done in})
    }
    
}

protocol ConferenceModelViewProtocol {
    func loadData()
}
