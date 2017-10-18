//
//  ZoomableImageViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 9/12/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ZoomableImageViewController: UIViewController, UIScrollViewDelegate, StoryboardIdentifiable {
    
    @IBOutlet weak var baseScrollView: UIScrollView?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var closeButton: UIButton!
    
    private var isCompletedLayoutSubviews = false
    
    static func build() -> ZoomableImageViewController {
        let zoomableImageViewController: ZoomableImageViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        return zoomableImageViewController
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
                self.closeButton.alpha = 0
                }, completion: { _ in
                    self.closeButton.isHidden = true
            })
        } else {
            closeButton.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.closeButton.alpha = 1
            })
        }
    }
    
    // MARK: - Scroll View Delegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        closeButton.isHidden = true
    }
    
    @objc func singleTap(_ gesture: UITapGestureRecognizer) {
        toggleToolBarHiddenWithAnimation(!closeButton.isHidden)
    }
    
    @objc func doubleTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            self.baseScrollView?.zoomScale = 1
        }) 
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
