//
//  TalkDetailViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/23.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalkDetailViewController: UIViewController {
    
    var talk: Talk?
    private let _localNotificationManager = LocalNotificationManager()

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var abstractTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = "hogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehogehogehogehgoehoge"
        
        abstractTextView.text = "fugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafugafuga"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func swithNotification(sender: UISwitch) {
        if let talk = talk {
            if (talk.isSetNotification) {
                _localNotificationManager.makeNotification(talk)
            } else {
                _localNotificationManager.cancelSchedule(talk)
            }
        }
    }
    @IBAction func onHashTagButton(sender: UIButton) {

        var hashTag = "pyconjp"
        if let talk = talk, room = talk.place?.name {
                hashTag.appendContentsOf(room)
        }
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "twitter://")!) {
            let urlString = "twitter://search?query=%23" + hashTag
            UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        } else {
            let urlString = "https://mobile.twitter.com/search?q=%23" + hashTag + "&s=typd"
            
            let webViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PCJWKWebViewController") as! PCJWKWebViewController
            webViewController.url = urlString
            self.presentViewController(webViewController, animated: true, completion: nil)
        }
      
    }
}
