//
//  PCJWKWebViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/26.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebKit

class PCJWKWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webContentView: UIView!
    
    private var url: String = ""
    
    class func build(url: String) -> PCJWKWebViewController {
        let pcjWKWebViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PCJWKWebViewController") as! PCJWKWebViewController
        pcjWKWebViewController.url = url
        return pcjWKWebViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webContentView.addSubview(webView)
        
        let noLayoutFormatOptions = NSLayoutFormatOptions(rawValue: 0)
        webContentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|", options: noLayoutFormatOptions, metrics: nil, views: ["webView": webView]))
        
        webContentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|", options: noLayoutFormatOptions, metrics: nil, views: ["webView": webView]))
        
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let url = navigationAction.request.url else {
            return nil
        }
        guard let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame else {
            webView.load(URLRequest.init(url: url))
            return nil
        }
        
        return nil
    }
    
    @IBAction func onCleseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
