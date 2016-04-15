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

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var abstractTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func swithNotification(sender: UISwitch) {
        print("hogehoge")
    }
}
