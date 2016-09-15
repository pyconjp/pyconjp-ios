//
//  ZoomableImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/12/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ZoomableImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var baseScrollView: UIScrollView?
    @IBOutlet weak var imageView: UIImageView?
    
    class func build() -> ZoomableImageViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ZoomableImageViewController") as! ZoomableImageViewController
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return toolBar.hidden
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
    
    override func viewDidLoad() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ZoomableImageViewController.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ZoomableImageViewController.singleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.requireGestureRecognizerToFail(doubleTapGesture)
        view.addGestureRecognizer(singleTapGesture)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {
        toolBar.hidden = !toolBar.hidden
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2) {
            self.baseScrollView?.zoomScale = 1
        }
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        toolBar.hidden = true
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func onCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
