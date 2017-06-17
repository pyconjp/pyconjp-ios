//
//  ConferenceTimetableDataStore.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/18.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import Foundation
import UIKit

final class ConferenceTimetableDataStore {
    
    var timetable: Timetable
    
    private let loadTalksRequest: LoadTalksRequest
    private let apiRequest: TalksAPIRequest = TalksAPIRequest()
    
    init?(day: String) {
        self.loadTalksRequest = LoadTalksRequest(day: day)
        do {
            self.timetable = Timetable(talks: try loadTalksRequest.load())
        } catch {
            return nil
        }
    }
    
    func numberOfColumns() -> Int {
        return timetable.rooms.count + 1
    }
    
    func numberOfRows() -> Int {
        return Int(timetable.timeLength ?? 0.0) + 1
    }
    
    func widthForColumn(_ column: Int) -> CGFloat {
        return 0.0
    }
    
    func heightForRow(_ row: Int) -> CGFloat {
        return 0.0
    }
    
}
