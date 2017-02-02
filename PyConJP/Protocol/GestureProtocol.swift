//
//  GestureProtocol.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/13/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol GestureProtocol {
    func handle(gesture: UIGestureRecognizer)
    func singleTap(gesture: UITapGestureRecognizer)
    func doubleTap(gesture: UITapGestureRecognizer)
    func pinch(gesture: UIPinchGestureRecognizer)
    func pan(gesture: UIPanGestureRecognizer)
    func longPress(gesture: UILongPressGestureRecognizer)
}

extension GestureProtocol {

    func handle(gesture: UIGestureRecognizer) {
        if let singleTapGesture = gesture as? UITapGestureRecognizer, singleTapGesture.numberOfTapsRequired == 1 {
            singleTap(gesture: singleTapGesture)
        } else if let doubleTapGesture = gesture as? UITapGestureRecognizer, doubleTapGesture.numberOfTapsRequired == 2 {
            doubleTap(gesture: doubleTapGesture)
        } else if let pinchGesture = gesture as? UIPinchGestureRecognizer {
            pinch(gesture: pinchGesture)
        } else if let panGesture = gesture as? UIPanGestureRecognizer {
            pan(gesture: panGesture)
        } else if let longPressGesture = gesture as? UILongPressGestureRecognizer {
            longPress(gesture: longPressGesture)
        }
    }
    
    func singleTap(gesture: UITapGestureRecognizer) {}

    func doubleTap(gesture: UITapGestureRecognizer) {}

    func pinch(gesture: UIPinchGestureRecognizer) {}

    func pan(gesture: UIPanGestureRecognizer) {}

    func longPress(gesture: UILongPressGestureRecognizer) {}

}
