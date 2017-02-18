//
//  TalkTableViewCell.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/07.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class TalkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var speakerLabel: UILabel!
    
    static let estimatedRowHeight: CGFloat = 134
    
    override func prepareForReuse() {
        titleLabel.text = nil
        timeLabel.text = nil
        placeLabel.text = nil
        speakerLabel.text = nil
        placeView.backgroundColor = UIColor.darkGray
    }
    
    func fill(talkObject: TalkObject) {
        titleLabel.text = talkObject.title
        timeLabel.text = talkObject.periodTime
        placeLabel.text = talkObject.place
        speakerLabel.text = talkObject.speakers
        if let room = talkObject.room {
            placeView.backgroundColor = room.color
        }
    }
    
}
