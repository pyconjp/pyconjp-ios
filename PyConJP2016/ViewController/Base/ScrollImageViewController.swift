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
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
//            if let size = imageView.image?.size {
//                // imageViewのサイズがscrollView内に収まるように調整
//                let wrate = baseScrollView.frame.width / size.width
//                let hrate = baseScrollView.frame.height / size.height
//                let rate = min(wrate, hrate, 1)
//                imageView.frame.size = CGSize(width: size.width * rate, height: size.height * rate)
//                
//                // contentSizeを画像サイズに設定
//                baseScrollView.contentSize = imageView.frame.size
//                // 初期表示のためcontentInsetを更新
//                updateScrollInset()
//            }
        }
    }

    class func build() -> ScrollImageViewController {
        let scrollImageViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("ScrollImageViewController") as! ScrollImageViewController
        return scrollImageViewController
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        updateScrollInset()
    }
    
    private func updateScrollInset() {
        baseScrollView.contentInset = UIEdgeInsets(
            top: max((baseScrollView.frame.height - imageView.frame.height)/2, 0),
            left: max((baseScrollView.frame.width - imageView.frame.width)/2, 0),
            bottom: 0,
            right: 0
        )
    }
    
    @IBAction func onCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
