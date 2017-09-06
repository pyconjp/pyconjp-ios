//
//  SpeakerCollectionViewCell.swift
//  PyConJP
//
//  Created by Yutaro Muta on 9/8/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework

class SpeakerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    
    override func prepareForReuse() {
        iconImageView.image = #imageLiteral(resourceName: "Speaker")
        nameLabel.text = nil
        twitterLabel.text = nil
    }
    
    func fill(speaker: Speaker) {
        iconImageView.setImage(withURL: URL(string: WebConfig.hostURL + (speaker.imageURL ?? "")),
                               imageTrainsition: UIImageView.ImageTransition.crossDissolve(0.3))
        nameLabel.text = speaker.name
        twitterLabel.text = (speaker.twitterName != nil ? "@\(speaker.twitterName!)" : nil)
    }
    
}
