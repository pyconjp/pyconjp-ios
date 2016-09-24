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
    
    private var isCompletedLayoutSubviews = false
    
    class func build() -> ZoomableImageViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ZoomableImageViewController") as! ZoomableImageViewController
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return isCompletedLayoutSubviews
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        isCompletedLayoutSubviews = true
        self.setNeedsStatusBarAppearanceUpdate()
        toggleToolBarHiddenWithAnimation(false)
    }
    
    private func toggleToolBarHiddenWithAnimation(toHidden: Bool) {
        if toHidden {
            UIView.animateWithDuration(0.2, animations: {
                self.toolBar.alpha = 0
                }, completion: { finished in
                    self.toolBar.hidden = true
            })
        } else {
            toolBar.hidden = false
            UIView.animateWithDuration(0.2, animations: {
                self.toolBar.alpha = 1
            })
        }
    }
    
    // MARK: - Scroll View Delegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        toolBar.hidden = true
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {
        toggleToolBarHiddenWithAnimation(!toolBar.hidden)
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2) {
            self.baseScrollView?.zoomScale = 1
        }
    }
    
    @IBAction func onCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
