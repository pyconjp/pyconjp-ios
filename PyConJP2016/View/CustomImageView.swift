//
//  CustomImageView.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    //* Gesture Enabled Whether or not */
    var gestureEnabled = true
    
    private var beforePoint = CGPoint(x: 0.0, y: 0.0)
    private var currentScale: CGFloat = 1.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.userInteractionEnabled = true
        
        //        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(CustomImageView.handleGesture(_:)))
        //        doubleTapGesture.numberOfTapsRequired = 2
        //        self.addGestureRecognizer(doubleTapGesture)
        //
        //        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(CustomImageView.handleGesture(_:)))
        //        self.addGestureRecognizer(pinchGesture)
        //
        //        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(CustomImageView.handleGesture(_:)))
        //        self.addGestureRecognizer(longPressGesture)
        //
        //        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(CustomImageView.handleGesture(_:)))
        //        self.addGestureRecognizer(panGesture)
    }
    
    func handleGesture(gesture: UIGestureRecognizer) {
        if let doubleTapGesture = gesture as? UITapGestureRecognizer {
            doubleTap(doubleTapGesture)
        } else if let pinchGesture = gesture as? UIPinchGestureRecognizer {
            pinch(pinchGesture)
        } else if let panGesture = gesture as? UIPanGestureRecognizer {
            pan(panGesture)
        }
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) {
        if gestureEnabled {
            beforePoint = CGPoint(x: 0.0, y: 0.0)
            currentScale = 1.0
            UIView.animateWithDuration(0.2, animations: { [weak self]() in
                self?.transform = CGAffineTransformIdentity
                })
        }
    }
    
    private func pinch(gesture: UIPinchGestureRecognizer) {
        if gestureEnabled {
            var scale = gesture.scale
            if currentScale > 1.0 {
                scale = currentScale + (scale - 1.0)
            }
            
            switch gesture.state {
            case .Changed:
                let scaleTransform = CGAffineTransformMakeScale(scale, scale)
                let transitionTransform = CGAffineTransformMakeTranslation(beforePoint.x, beforePoint.y)
                transform = CGAffineTransformConcat(scaleTransform, transitionTransform)
            case .Ended, .Cancelled:
                if scale <= 1.0 {
                    beforePoint = CGPoint(x: 0.0, y: 0.0)
                    currentScale = 1.0
                    UIView.animateWithDuration(0.1, animations: { [weak self]() in
                        self?.transform = CGAffineTransformIdentity
                        })
                } else {
                    currentScale = scale
                }
            default:
                break
            }
        }
    }
    
    private func pan(gesture: UIPanGestureRecognizer) {
        if currentScale == 1.0 { return }
        if let gestureView = gesture.view where gestureEnabled {
            
            var translation = gesture.translationInView(gestureView)
            
            if abs(beforePoint.x) > 0.0 || abs(beforePoint.y) > 0.0 {
                translation = CGPoint(x: beforePoint.x + translation.x, y: beforePoint.y + translation.y)
            }
            
            switch gesture.state {
            case .Changed:
                let scaleTransform = CGAffineTransformMakeScale(currentScale, currentScale)
                let translationTransform = CGAffineTransformMakeTranslation(translation.x, translation.y)
                transform = CGAffineTransformConcat(scaleTransform, translationTransform)
            case .Ended, .Cancelled:
                beforePoint = translation
            default:
                break
            }
        }
    }
    
}
