//
//  TalkDetailViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/23.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices
import RealmSwift

class TalkDetailViewController: UIViewController, TalkDetailAPIProtocol, TwitterURLSchemeProtocol, ErrorAlertProtocol {
    
    @IBOutlet weak var baseScrollView: UIScrollView! {
        didSet {
            refreshControl.addTarget(self, action: #selector(TalkDetailViewController.refresh(_:)), for: .valueChanged)
            baseScrollView.addSubview(refreshControl)
        }
    }
    @IBOutlet weak var bookmarkBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var periodTimeLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var hashTagButton: UIButton!
    
    @IBOutlet weak var speakersCollectionView: UICollectionView! {
        didSet {
            let nib  = UINib(nibName: speakersCollectionViewDataSource.reuseIdentifier, bundle:nil)
            speakersCollectionView.register(nib, forCellWithReuseIdentifier: speakersCollectionViewDataSource.reuseIdentifier)
            speakersCollectionView.dataSource = speakersCollectionViewDataSource
        }
    }
    @IBOutlet weak var speakersCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var abstractTextView: UITextView!
    
    var id: Int?
    private var talkDetail: TalkDetail? {
        didSet {
            if let talkDetail = talkDetail {
                speakersCollectionViewDataSource.speakers = talkDetail.speakers
            } else {
                speakersCollectionViewDataSource.speakers.removeAll()
            }
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    private let speakersCollectionViewDataSource = SpeakersCollectionViewDataSource()
    
    private lazy var speakersCollectionViewHeight: CGFloat = self.speakersCollectionViewHeightConstraint.constant
    
    class func build(id: Int) -> TalkDetailViewController {
        let talkDetailViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TalkDetailViewController") as! TalkDetailViewController
        talkDetailViewController.id = id
        return talkDetailViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.beginRefreshing()
        getDetail()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let talkDetail = talkDetail else { return }
        do {
            let realm = try Realm()
            if let talkObject = realm.object(ofType: TalkObject.self, forPrimaryKey: id as AnyObject) {
                talkDetail.talkObject.favorited = talkObject.favorited
                toggleBookmarkBarButtonItem(isFavorite: talkDetail.talkObject.favorited)
            }
        } catch {
            
        }
        
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        talkDetail = nil
        getDetail()
    }
    
    private func getDetail() {
        getTalkDetail { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let talkDetail):
                weakSelf.talkDetail = talkDetail
                weakSelf.fillData()
                weakSelf.refreshControl.endRefreshing()
            case .failure(let error):
                weakSelf.refreshControl.endRefreshing()
                weakSelf.showErrorAlart(with: error, parent: weakSelf)
            }
        }
    }
    
    private func fillData() {
        guard let talkDetail = talkDetail else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = talkDetail.talkObject.title
            
            self.dayLabel.text = talkDetail.talkObject.day
            self.periodTimeLabel.text = talkDetail.talkObject.periodTime
            
            self.placeLabel.text = talkDetail.talkObject.place
            self.placeLabel.textColor = talkDetail.talkObject.room?.color ?? UIColor.black
            self.hashTagButton.setTitle((talkDetail.talkObject.room?.hashTag ?? "#pyconjp"), for: UIControlState())
            
            self.speakersCollectionViewHeightConstraint.constant = talkDetail.speakers.isEmpty ? 0 : self.speakersCollectionViewHeight
            self.speakersCollectionView.reloadData()
            
            self.languageLabel.text = talkDetail.talkObject.languageType?.localized
            self.levelLabel.text = talkDetail.level
            self.categoryLabel.text = talkDetail.talkObject.category
            
            self.descriptionTextView.text = talkDetail.talkObject.descriptionText
            self.abstractTextView.text = talkDetail.abstract
            
            self.toggleBookmarkBarButtonItem(isFavorite: talkDetail.talkObject.favorited)
        }
        
    }
    
    func toggleBookmarkBarButtonItem(isFavorite: Bool) {
        let image = isFavorite ? #imageLiteral(resourceName: "BookmarkOn") : #imageLiteral(resourceName: "BookmarkOff")
        DispatchQueue.main.async {
            self.bookmarkBarButtonItem.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBookmarkBarButton(_ sender: UIBarButtonItem) {
        guard let talkDetail = talkDetail else { return }
        do {
            talkDetail.talkObject.favorited = !talkDetail.talkObject.favorited
            let realm = try Realm()
            try realm.write({
                realm.create(TalkObject.self, value: ["id": talkDetail.talkObject.id, "favorited": talkDetail.talkObject.favorited], update: true)
            })
            toggleBookmarkBarButtonItem(isFavorite: talkDetail.talkObject.favorited)
        } catch {
            
        }
    }
    
    @IBAction func onHashTagButton(_ sender: UIButton) {
        let hashTag = (talkDetail?.talkObject.room?.hashTag ?? "pyconjp").replacingOccurrences(of: "#", with: "")
        openTwitter(hashTag: hashTag, from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let userName = speakersCollectionViewDataSource.speakers[(indexPath as NSIndexPath).row].twitterName else { return }
        openTwitter(userName: userName, from: self)
    }
}
