//
//  TalkDetailViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/23.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalkDetailViewController: UIViewController, TalkDetailAPIType, ErrorAlertType {

    @IBOutlet weak var baseScrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var periodTimeLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var hashTagButton: UIButton!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var abstractTextView: UITextView!
    
    var id: Int?
    var talkDetail: TalkDetailStruct?
    private let _localNotificationManager = LocalNotificationManager()
    let refreshControl = UIRefreshControl()
    
    class func build() -> TalkDetailViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("TalkDetailViewController") as! TalkDetailViewController
    }
    
    class func build(id: Int) -> TalkDetailViewController {
        let talkDetailViewController = TalkDetailViewController.build()
        talkDetailViewController.id = id
        return talkDetailViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(TalkDetailViewController.refresh(_:)), forControlEvents: .ValueChanged)
        baseScrollView.addSubview(refreshControl)
        
//        refreshControl.beginRefreshing()
        getDetail()

    }
    
    func refresh(refreshControl: UIRefreshControl) {
        talkDetail = nil
        getDetail()
    }
    
    private func getDetail() {
//        getTalkDetailFromLocalDummyJson(successClosure: { (talkDetail) in
        getTalkDetail(successClosure: { (talkDetail) in
            self.talkDetail = talkDetail
            self.fillData()
            self.refreshControl.endRefreshing()
        }) { [weak self](error) in
            self?.refreshControl.endRefreshing()
            guard let weakSelf = self else { return }
            weakSelf.showErrorAlartWith(error, parent: weakSelf)
        }
    }
    
    private func fillData() {
        guard let talkDetail = talkDetail else { return }
        titleLabel.text = talkDetail.talkObject.title
        
        dayLabel.text = talkDetail.talkObject.day
        periodTimeLabel.text = talkDetail.talkObject.periodTime
        
        placeLabel.text = talkDetail.talkObject.place
        hashTagButton.setTitle("#pyconjp\(talkDetail.talkObject.place)", forState: .Normal)
        
        speakerNameLabel.text = talkDetail.talkObject.speakers
        
        languageLabel.text = talkDetail.talkObject.languageName()
        levelLabel.text = talkDetail.level
        categoryLabel.text = talkDetail.talkObject.category
        
        descriptionTextView.text = talkDetail.talkObject.descriptionText
        abstractTextView.text = talkDetail.abstract
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    @IBAction func swithNotification(sender: UISwitch) {
//        if let talkDetail = talkDetail {
//            if talkDetail.isSetNotification {
//                _localNotificationManager.makeNotification(talkDetail)
//            } else {
//                _localNotificationManager.cancelSchedule(talkDetail)
//            }
//        }
//    }
    
    @IBAction func onHashTagButton(sender: UIButton) {

        var hashTag = "pyconjp"
        if let talkDetail = talkDetail, roomNumber = talkDetail.talkObject.place .componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).last {
            hashTag.appendContentsOf(roomNumber)
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
