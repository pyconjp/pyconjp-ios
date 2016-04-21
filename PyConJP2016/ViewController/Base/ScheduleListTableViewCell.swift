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
        speakerLabel.text = talk.speaker?.name
        timeLabel.text =  talk.periodTime
        roomLabel.text = talk.place?.name
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        timeLabel.text = nil
        roomLabel.text = nil
        speakerLabel.text = nil
    }
    
}
