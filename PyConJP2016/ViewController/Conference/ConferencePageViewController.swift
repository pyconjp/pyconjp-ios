//
//  ConferencePageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferencePageViewController: UIPageViewController, ConferencePageViewProtocol, ErrorAlertType {
    
    private var conferenceModelViewProtocol: ConferenceModelViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startingViewController = self.conferenceModelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
        
        self.dataSource = self.conferenceModelController
        
    }
    
    private var _conferenceModelController: ConferenceModelController? = nil
    
    private var conferenceModelController: ConferenceModelController {
        if _conferenceModelController == nil {
            _conferenceModelController = ConferenceModelController()
        }
        return _conferenceModelController!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
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
        self.movePage(index, direction: .Forward)
    }
    
    func reversePage(index: Int) {
        self.movePage(index, direction: .Reverse)
    }
    
    private func movePage(index: Int, direction: UIPageViewControllerNavigationDirection) {
        let viewController = conferenceModelController.viewControllerAtIndex(index, storyboard: self.storyboard!)!
        let viewControllers = [viewController]
        self.setViewControllers(viewControllers, direction: direction, animated: true, completion: {done in})
    }
    
}

protocol ConferenceModelViewProtocol {
    func loadData()
}
