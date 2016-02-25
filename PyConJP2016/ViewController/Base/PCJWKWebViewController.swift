//
//  PCJWKWebViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/26.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit
import WebKit

class PCJWKWebViewController: UIViewController, WKNavigationDelegate {
    
    var url: String = "https://google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: CGRectZero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        let noLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|", options: noLayoutFormatOptions, metrics: nil, views: ["webView": webView]))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: noLayoutFormatOptions, metrics: nil, views: ["webView": webView]))
        
        let request = NSURLRequest(URL: NSURL(string: url)!)
        webView.loadRequest(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    }
    
}
