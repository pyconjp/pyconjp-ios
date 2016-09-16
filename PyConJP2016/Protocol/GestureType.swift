//
//  GestureType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/13/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol GestureType {
    func handleGesture(gesture: UIGestureRecognizer)
    func singleTap(gesture: UITapGestureRecognizer)
    func doubleTap(gesture: UITapGestureRecognizer)
    func pinch(gesture: UIPinchGestureRecognizer)
    func pan(gesture: UIPanGestureRecognizer)
    func longPress(gesture: UILongPressGestureRecognizer)
}

extension GestureType {

    func handleGesture(gesture: UIGestureRecognizer) {
        if let singleTapGesture = gesture as? UITapGestureRecognizer where singleTapGesture.numberOfTapsRequired == 1 {
            singleTap(singleTapGesture)
        } else if let doubleTapGesture = gesture as? UITapGestureRecognizer where doubleTapGesture.numberOfTapsRequired == 2 {
            doubleTap(doubleTapGesture)
        } else if let pinchGesture = gesture as? UIPinchGestureRecognizer {
            pinch(pinchGesture)
        } else if let panGesture = gesture as? UIPanGestureRecognizer {
            pan(panGesture)
        } else if let longPressGesture = gesture as? UILongPressGestureRecognizer {
            longPress(longPressGesture)
        }
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {}

    func doubleTap(gesture: UITapGestureRecognizer) {}

    func pinch(gesture: UIPinchGestureRecognizer) {}

    func pan(gesture: UIPanGestureRecognizer) {}

    func longPress(gesture: UILongPressGestureRecognizer) {}

}
