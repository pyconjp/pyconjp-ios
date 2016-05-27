//
//  ScheduleListTableViewCell.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class ScheduleListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fillWith(talk: Talk) {
        titleLabel.text = talk.title
        if let speaker = talk.speaker {
            speakerLabel.text = speaker.name
        }
        timeLabel.text =  talk.periodTime
        if let plase = talk.place {
            roomLabel.text = plase.name
            self.fillRoomColorWith(plase.id)
        }
    }
    
    private func fillRoomColorWith(id: Int) {
        switch id {
        case 201:
            roomLabel.backgroundColor = .redColor()
        default:
            roomLabel.backgroundColor = .grayColor()
        }
    }
    
    override func prepareForReuse() {
//        titleLabel.text = nil
//        timeLabel.text = nil
//        roomLabel.text = nil
//        speakerLabel.text = nil
//        self.fillRoomColorWith(0)
    }
    
}
