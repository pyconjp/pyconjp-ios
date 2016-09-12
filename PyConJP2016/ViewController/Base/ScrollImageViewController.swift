//
//  ScrollImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/12/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ScrollImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    class func build() -> ScrollImageViewController {
        let scrollImageViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ScrollImageViewController") as! ScrollImageViewController
        return scrollImageViewController
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ScrollImageViewController.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ScrollImageViewController.singleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.requireGestureRecognizerToFail(doubleTapGesture)
        view.addGestureRecognizer(singleTapGesture)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {
        if toolBar.hidden {
            toolBar.hidden = false
            UIView.animateWithDuration(0.2, animations: {
                self.toolBar.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.toolBar.alpha = 0
                }, completion: { finished in
                    self.toolBar.hidden = true
            })
        }
        
    }
    
    //    func scrollViewDidZoom(scrollView: UIScrollView) {
    //        updateScrollInset()
    //    }
    //
    //    private func updateScrollInset() {
    //        baseScrollView.contentInset = UIEdgeInsets(
    //            top: max((baseScrollView.frame.height - imageView.frame.height)/2, 0),
    //            left: max((baseScrollView.frame.width - imageView.frame.width)/2, 0),
    //            bottom: 0,
    //            right: 0
    //        )
    //    }
    
    func doubleTap(gesture: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2) {
            self.baseScrollView.zoomScale = 1
        }
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        toolBar.hidden = true
    }
    
    @IBAction func onCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
