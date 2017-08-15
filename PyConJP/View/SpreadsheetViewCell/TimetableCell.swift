//
//  TimetableCell.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/17.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit
import SpreadsheetView

final class TimetableCell: Cell, NibInstantitable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    
    static let width: CGFloat = 130.0
    static let height: CGFloat = 2.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gridlines = Gridlines.all(.solid(width: 1.0, color: .gray))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        timeLabel.text = nil
        speakerLabel.text = nil
    }
    
    func fill(_ talkObject: TalkObject) {
        titleLabel.text = talkObject.title
        timeLabel.text = talkObject.periodTime
        speakerLabel.text = talkObject.speakers
    }
    
}
