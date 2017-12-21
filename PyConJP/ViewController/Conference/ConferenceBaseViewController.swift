//
//  ConferenceBaseViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceBaseViewController: UIViewController, UIPageViewControllerDelegate {
    
    @IBOutlet weak var barContainerView: UIView!
    @IBOutlet weak var pageContainerView: UIView!
    
    var conferenceDateViewProtocol: ConferenceDateViewProtocol?
    var conferencePageViewProtocol: ConferencePageViewProtocol?
    
    private var displayIndex: Int = 0 {
        didSet {
            if let conferenceDateViewProtocol = conferenceDateViewProtocol {
                conferenceDateViewProtocol.changeActive(index: displayIndex)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conferencePageViewController = ConferencePageViewController.build()
        conferencePageViewController.view.frame = pageContainerView.bounds
        self.addChildViewController(conferencePageViewController)
        pageContainerView.addSubview(conferencePageViewController.view)
        conferencePageViewController.didMove(toParentViewController: self)
        
        let conferenceDateViewController = ConferenceDateViewController.build()
        conferenceDateViewController.view.frame = barContainerView.bounds
        self.addChildViewController(conferenceDateViewController)
        barContainerView.addSubview(conferenceDateViewController.view)
        conferenceDateViewController.didMove(toParentViewController: self)
        
    }
    
}

protocol ConferencePageViewProtocol {
    func fowardPage(index: Int)
    func reversePage(index: Int)
}

protocol ConferenceDateViewProtocol {
    func changeActive(index: Int)
}
