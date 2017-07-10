//
//  TimetableRoomCell.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/18.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit
import SpreadsheetView

final class TimetableRoomCell: Cell, NibInstantitable {
    
    @IBOutlet weak var roomLabel: UILabel!
    
    static let width: CGFloat = 130.0
    static let height: CGFloat  = 44.0
    
    func fill(_ room: Room) {
        roomLabel.text = room.description
        backgroundColor = room.color
    }

}

extension TimetableCellProtocol where Self: Cell {
    
}

protocol TimetableCellProtocol {}

extension TimetableRoomCell: TimetableCellProtocol {
    
}