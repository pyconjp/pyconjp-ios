//
//  TalksBaseViewController.swift
//  PyConJP2016
//
//  Created by 牟田　裕太郎 on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksBaseViewController: UIViewController, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    var moveLength: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
}

