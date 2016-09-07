//
//  SpeakerCollectionViewCell.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/8/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class SpeakerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    
    override func prepareForReuse() {
        iconImageView.image = nil
        nameLabel.text = nil
        twitterLabel.text = nil
    }
    
    func fill(speaker: Speaker) {
        
        nameLabel.text = speaker.name
        twitterLabel.text = speaker.twitterName
    }
    
}
