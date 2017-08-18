//
//  ConferencePageViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferencePageViewController: UIPageViewController, ErrorAlertProtocol {
    
    private var conferenceModelViewProtocol: ConferenceModelViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let startingViewController = conferenceModelController.viewController(index: 0) else { return }
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers, direction: .forward, animated: false)
        
//        self.dataSource = self.conferenceModelController
        
    }
    
    private var _conferenceModelController: ConferenceModelController?
    
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
        guard let conferenceBaseViewController = parent as? ConferenceBaseViewController else { return }
//        self.delegate = conferenceBaseViewController
        conferenceBaseViewController.conferencePageViewProtocol = self
        
//        self.view.subviews.forEach {
//            if let scrollView = $0 as? UIScrollView {
//                scrollView.delegate = conferenceBaseViewController
//            }
//        }
    }
    
}

extension ConferencePageViewController: ConferencePageViewProtocol {
    
    func fowardPage(index: Int) {
        movePage(index: index, direction: .forward)
    }
    
    func reversePage(index: Int) {
        movePage(index: index, direction: .reverse)
    }
    
    private func movePage(index: Int, direction: UIPageViewControllerNavigationDirection) {
        guard let viewController = conferenceModelController.viewController(index: index) else { return }
        let viewControllers = [viewController]
        setViewControllers(viewControllers, direction: direction, animated: true)
    }
    
}

protocol ConferenceModelViewProtocol {
    func loadData()
}
