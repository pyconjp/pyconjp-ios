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
    let pyconJPDate: PyConJPDate
    
    private let loadTalksRequest: LoadTalksRequest
    private let apiRequest: TalksAPIRequest = TalksAPIRequest()
    
    init?(pyconJPDate: PyConJPDate) {
        self.pyconJPDate = pyconJPDate
        self.loadTalksRequest = LoadTalksRequest(day: pyconJPDate.description)
        do {
            self.timetable = Timetable(talks: try loadTalksRequest.load())
        } catch {
            return nil
        }
    }
    
    func numberOfColumns() -> Int {
        return Section.numberOfColumns(timetable.rooms.count)
    }
    
    func numberOfRows() -> Int {
        return Section.numberOfRows(Int(timetable.timeLength ?? 0.0))
    }
    
    func cellIdentifier(_ indexPath: IndexPath) -> String? {
        guard let section = Section(indexPath: indexPath) else { return nil }
        return section.cellIdentifier
    }
    
    func widthForColumn(_ column: Int) -> CGFloat {
        guard let section = Section(indexPath: IndexPath(row: 0, column: column)) else { return 0.0 }
//        return section.widthForColumn
        return CGFloat(10 * column)
    }
    
    func heightForRow(_ row: Int) -> CGFloat {
        guard let section = Section(indexPath: IndexPath(row: row, column: 0)) else { return 0.0 }
//        return section.heightForRow
        return CGFloat(row)
    }
    
    enum Section {
        case rowHeader
        case columnHeader
        case timetable
        
        init?(indexPath: IndexPath) {
            switch (indexPath.row, indexPath.column) {
            case (0, 0):
                return nil
            case (0, _):
                self = .rowHeader
            case (_, 0):
                self = .columnHeader
            default:
                self = .timetable
            }
        }
        
        var cellIdentifier: String {
            switch self {
            case .rowHeader:
                return TimetableRoomCell.nibName
            case .columnHeader:
                return TimetableTimeAxisCell.nibName
            case .timetable:
                return TimetableCell.nibName
            }
        }
        
        var widthForColumn: CGFloat {
            switch self {
            case .rowHeader:
                return 130
            case .columnHeader:
                return 200
            case .timetable:
                return 130
            }
        }
        
        var heightForRow: CGFloat {
            switch self {
            case .rowHeader:
                return 44
            case .columnHeader:
                return 2
            case .timetable:
                return 2
            }
        }
        
        static func numberOfColumns(_ count: Int) -> Int {
            return count + 1
        }
        
        static func numberOfRows(_ length: Int) -> Int {
            return length + 1
        }
    }
    
}
