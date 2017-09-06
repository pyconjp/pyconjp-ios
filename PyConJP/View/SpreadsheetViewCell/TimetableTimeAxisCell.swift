//
//  TimetableTimeAxisCell.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/18.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit
import SpreadsheetView

final class TimetableTimeAxisCell: Cell, NibInstantitable {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    static let width: CGFloat = 44.0
    static let height: CGFloat = 3.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gridlines = Gridlines.all(.solid(width: 1.0, color: .gray))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
    }
    
    func fill(_ hour: String) {
        timeLabel.text = hour
    }
    
}
