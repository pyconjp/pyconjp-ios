//
//  DetailImageViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/05.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    @IBOutlet weak var customImageView: CustomImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTapGesture = UITapGestureRecognizer(target: customImageView, action: #selector(CustomImageView.handleGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: customImageView, action: #selector(CustomImageView.handleGesture(_:)))
        view.addGestureRecognizer(pinchGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: customImageView, action: #selector(CustomImageView.handleGesture(_:)))
        view.addGestureRecognizer(longPressGesture)
        
        let panGesture = UIPanGestureRecognizer(target: customImageView, action: #selector(CustomImageView.handleGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
}
