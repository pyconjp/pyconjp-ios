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
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ZoomableImageViewController") as! ZoomableImageViewController
    }
    
    override var prefersStatusBarHidden: Bool {
        return isCompletedLayoutSubviews
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    override func viewDidLoad() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ZoomableImageViewController.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ZoomableImageViewController.singleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.require(toFail: doubleTapGesture)
        view.addGestureRecognizer(singleTapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        isCompletedLayoutSubviews = true
        self.setNeedsStatusBarAppearanceUpdate()
        toggleToolBarHiddenWithAnimation(false)
    }
    
    private func toggleToolBarHiddenWithAnimation(_ toHidden: Bool) {
        if toHidden {
            UIView.animate(withDuration: 0.2, animations: {
                self.toolBar.alpha = 0
                }, completion: { finished in
                    self.toolBar.isHidden = true
            })
        } else {
            toolBar.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.toolBar.alpha = 1
            })
        }
    }
    
    // MARK: - Scroll View Delegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        toolBar.isHidden = true
    }
    
    func singleTap(_ gesture: UITapGestureRecognizer) {
        toggleToolBarHiddenWithAnimation(!toolBar.isHidden)
    }
    
    func doubleTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            self.baseScrollView?.zoomScale = 1
        }) 
    }
    
    @IBAction func onCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
