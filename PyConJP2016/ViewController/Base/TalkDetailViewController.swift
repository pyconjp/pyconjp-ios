//
//  TalkDetailViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/23.
//  Copyright © 2016 PyCon JP. All rights reserved.
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
    private var talkTitle: String?
    private var talkDetail: TalkDetail?
    //    private let localNotificationManager = LocalNotificationManager()
    private let refreshControl = UIRefreshControl()
    
    class func build() -> TalkDetailViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("TalkDetailViewController") as! TalkDetailViewController
    }
    
    class func build(id: Int, title: String) -> TalkDetailViewController {
        let talkDetailViewController = TalkDetailViewController.build()
        talkDetailViewController.id = id
        talkDetailViewController.talkTitle = title
        return talkDetailViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(TalkDetailViewController.refresh(_:)), forControlEvents: .ValueChanged)
        baseScrollView.addSubview(refreshControl)
        
        refreshControl.beginRefreshing()
        getDetail()
        
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        talkDetail = nil
        getDetail()
    }
    
    private func getDetail() {
        getTalkDetail { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .Success(let talkDetail):
                weakSelf.talkDetail = talkDetail
                weakSelf.talkDetail?.talkObject.title = weakSelf.talkTitle ?? ""
                weakSelf.fillData()
                weakSelf.refreshControl.endRefreshing()
            case .Failure(let error):
                weakSelf.refreshControl.endRefreshing()
                weakSelf.showErrorAlartWith(error, parent: weakSelf)
            }
        }
    }
    
    private func fillData() {
        guard let talkDetail = talkDetail else { return }
        dispatch_async(dispatch_get_main_queue()) {
            self.titleLabel.text = talkDetail.talkObject.title
            
            self.dayLabel.text = talkDetail.talkObject.day
            self.periodTimeLabel.text = talkDetail.talkObject.periodTime
            
            self.placeLabel.text = talkDetail.talkObject.place
            self.placeLabel.textColor = talkDetail.talkObject.room?.color ?? UIColor.blackColor()
            self.hashTagButton.setTitle("#" + (talkDetail.talkObject.room?.hashTag ?? "pyconjp"), forState: .Normal)
            
            self.speakerNameLabel.text = talkDetail.talkObject.speakers
            
            self.languageLabel.text = talkDetail.talkObject.languageName
            self.levelLabel.text = talkDetail.level
            self.categoryLabel.text = talkDetail.talkObject.category
            
            self.descriptionTextView.text = talkDetail.talkObject.descriptionText
            self.abstractTextView.text = talkDetail.abstract
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    @IBAction func swithNotification(sender: UISwitch) {
    //        if let talkDetail = talkDetail {
    //            if talkDetail.isSetNotification {
    //                localNotificationManager.makeNotification(talkDetail)
    //            } else {
    //                localNotificationManager.cancelSchedule(talkDetail)
    //            }
    //        }
    //    }
    
    @IBAction func onHashTagButton(sender: UIButton) {
        
        let hashTag = talkDetail?.talkObject.room?.hashTag ?? "pyconjp"
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "twitter://")!) {
            let urlString = "twitter://search?query=%23" + hashTag
            UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        } else {
            let urlString = "https://mobile.twitter.com/search?q=%23" + hashTag + "&s=typd"
            
            let webViewController = PCJWKWebViewController.build(urlString)
            self.presentViewController(webViewController, animated: true, completion: nil)
        }
        
    }
}
