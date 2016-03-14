//
//  TalkTableViewCell.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/22.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalkTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var talk: Talk?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurationData(model: Talk) {
        talk = model
        titleLabel.text = model.title
        speakerLabel.text = model.speaker?.name
        timeLabel.text =  model.periodTime
        roomLabel.text = model.place?.name
        notificationSwitch.on = model.isSetNotification
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        timeLabel.text = nil
        roomLabel.text = nil
        speakerLabel.text = nil
        notificationSwitch.on = false
    }
    
    @IBAction func changeSwitch(sender: UISwitch) {
        if let talk = talk {
            let localNotificationManager = LocalNotificationManager()
            if (talk.isSetNotification) {
            	localNotificationManager.makeNotification(talk)
        	} else {
            	localNotificationManager.cancelSchedule(talk)
        	}
        }
    }
    
}
