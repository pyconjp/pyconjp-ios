//
//  GestureType.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/13/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

protocol GestureType {
    func handleGesture(_ gesture: UIGestureRecognizer)
    func singleTap(_ gesture: UITapGestureRecognizer)
    func doubleTap(_ gesture: UITapGestureRecognizer)
    func pinch(_ gesture: UIPinchGestureRecognizer)
    func pan(_ gesture: UIPanGestureRecognizer)
    func longPress(_ gesture: UILongPressGestureRecognizer)
}

extension GestureType {

    func handleGesture(_ gesture: UIGestureRecognizer) {
        if let singleTapGesture = gesture as? UITapGestureRecognizer, singleTapGesture.numberOfTapsRequired == 1 {
            singleTap(singleTapGesture)
        } else if let doubleTapGesture = gesture as? UITapGestureRecognizer, doubleTapGesture.numberOfTapsRequired == 2 {
            doubleTap(doubleTapGesture)
        } else if let pinchGesture = gesture as? UIPinchGestureRecognizer {
            pinch(pinchGesture)
        } else if let panGesture = gesture as? UIPanGestureRecognizer {
            pan(panGesture)
        } else if let longPressGesture = gesture as? UILongPressGestureRecognizer {
            longPress(longPressGesture)
        }
    }
    
    func singleTap(_ gesture: UITapGestureRecognizer) {}

    func doubleTap(_ gesture: UITapGestureRecognizer) {}

    func pinch(_ gesture: UIPinchGestureRecognizer) {}

    func pan(_ gesture: UIPanGestureRecognizer) {}

    func longPress(_ gesture: UILongPressGestureRecognizer) {}

}
