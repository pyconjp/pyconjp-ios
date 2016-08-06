//
//  UIViewExtention.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/02.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit

extension UIViewController {
  func topMostViewController() -> UIViewController {
    if let presentedViewController = self.presentedViewController {
      return presentedViewController.topMostViewController()
    } else {
      for view in self.view.subviews {
        if let subViewController = view.nextResponder() {
          if subViewController is UIViewController {
            let viewController = subViewController as! UIViewController
            return viewController.topMostViewController()
          }
        }
      }
      return self
    }
  }
}

extension UITabBarController {
  override func topMostViewController() -> UIViewController {
    return self.selectedViewController!.topMostViewController()
  }
}

extension UINavigationController {
  override func topMostViewController() -> UIViewController {
    return self.visibleViewController!.topMostViewController()
  }
}