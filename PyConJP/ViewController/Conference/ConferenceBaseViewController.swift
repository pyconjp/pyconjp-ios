//
//  ConferenceBaseViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceBaseViewController: UIViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var barContainerView: UIView!
    @IBOutlet weak var pageContainerView: UIView!
    
    var conferenceDateViewProtocol: ConferenceDateViewProtocol?
    var conferencePageViewProtocol: ConferencePageViewProtocol?
    
    private var offsetToChange: CGFloat = 0.0 {
        didSet {
            
        }
    }
    
    private var displayIndex: Int = 0 {
        didSet {
            if let conferenceDateViewProtocol = conferenceDateViewProtocol {
                conferenceDateViewProtocol.changeActive(index: displayIndex)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conferenceStoryboard = UIStoryboard(name: "Conference", bundle: Bundle.main)
        let conferencePageViewController = conferenceStoryboard.instantiateViewController(withIdentifier: "ConferencePageViewController")
        conferencePageViewController.view.frame = pageContainerView.bounds
        self.addChildViewController(conferencePageViewController)
        pageContainerView.addSubview(conferencePageViewController.view)
        conferencePageViewController.didMove(toParentViewController: self)
        
        let conferenceDateViewController = conferenceStoryboard.instantiateViewController(withIdentifier: "ConferenceDateViewController")
        conferenceDateViewController.view.frame = barContainerView.bounds
        self.addChildViewController(conferenceDateViewController)
        barContainerView.addSubview(conferenceDateViewController.view)
        conferenceDateViewController.didMove(toParentViewController: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        offsetToChange = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let displayViewController = pageViewController.viewControllers?.last as! ConferenceListViewController
        displayIndex = displayViewController.viewControllerIndex
        //        if 1 - barContainerView.frame.origin.x < 1 {
        //
        //        } else if 1 - (barContainerView.frame.size.width / 2) < 1 {
        //
        //        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x - pageContainerView.frame.size.width != 0 {
            offsetToChange = scrollView.contentOffset.x - pageContainerView.frame.size.width
        }
    }
    
}

protocol ConferencePageViewProtocol {
    func fowardPage(index: Int)
    func reversePage(index: Int)
}

protocol ConferenceDateViewProtocol {
    func changeActive(index: Int)
}
