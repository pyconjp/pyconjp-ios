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
    
    private(set) var timetable: Timetable
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
    
    var start: Date? {
        guard let start = timetable.start else { return nil }
        return start.calculate(minute: -(start.components.minute ?? 0), second: -(start.components.second ?? 0))
    }
    
    var end: Date? {
        guard let end = timetable.end else { return nil }
        return end.update(minute: 59, second: 59)
    }
    
    var frozenColumns: Int {
        return Section.frozenColumns
    }
    
    var frozenRows: Int {
        return Section.frozenRows
    }
    
    func room(_ indexPath: IndexPath) -> Room {
        return timetable.rooms[indexPath.column - Section.frozenColumns]
    }
    
    func hourClock(_ indexPath: IndexPath) -> String? {
        return start?.calculate(minute: indexPath.row)?.hourClock
    }
    
    func talk(_ indexPath: IndexPath) -> TalkObject? {
        guard let date = start?.calculate(minute: indexPath.row) else { return nil }
        return timetable.tracks[indexPath.column - Section.frozenColumns].talks.filter({ talkObject in
            return talkObject.startDate < date && date < talkObject.endDate
        }).first
    }
    
    func numberOfColumns() -> Int {
        return Section.numberOfColumns(timetable.rooms.count)
    }
    
    func numberOfRows() -> Int {
        return Section.numberOfRows(timetable.hourDuration.count * 60)
    }
    
    func cellIdentifier(_ indexPath: IndexPath) -> String? {
        return Section(indexPath: indexPath).cellIdentifier
    }
    
    func widthForColumn(_ column: Int) -> CGFloat {
        return Section(indexPath: IndexPath(row: 0, column: column)).width(of: timetable.rooms.count)
    }
    
    func heightForRow(_ row: Int) -> CGFloat {
        return Section(indexPath: IndexPath(row: row, column: 0)).height
    }
    
    func reloadTimetable() {
        do {
            self.timetable = Timetable(talks: try loadTalksRequest.load())
        } catch {
            return
        }
    }
    
    enum Section {
        case corner
        case rowHeader
        case columnHeader
        case timetable
        
        init(indexPath: IndexPath) {
            switch (indexPath.row, indexPath.column) {
            case (0, 0):
                self = .corner
            case (0, _):
                self = .rowHeader
            case (_, 0):
                self = .columnHeader
            default:
                self = .timetable
            }
        }
        
        var cellIdentifier: String? {
            switch self {
            case .corner:
                return nil
            case .rowHeader:
                return TimetableRoomCell.nibName
            case .columnHeader:
                return TimetableTimeAxisCell.nibName
            case .timetable:
                return TimetableCell.nibName
            }
        }
        
        func width(of columnCount: Int) -> CGFloat {
            switch self {
            case .corner:
                return TimetableTimeAxisCell.width
            case .rowHeader, .timetable:
                let timetableWidth: CGFloat = UIScreen.main.bounds.width - TimetableTimeAxisCell.width
                if timetableWidth < TimetableRoomCell.width * CGFloat(columnCount) {
                    return TimetableCell.width
                } else {
                    return timetableWidth / CGFloat(columnCount)
                }
            case .columnHeader:
                return TimetableTimeAxisCell.width
            }
        }
        
        var height: CGFloat {
            switch self {
            case .corner, .rowHeader:
                return TimetableRoomCell.height
            case .columnHeader:
                return TimetableTimeAxisCell.height
            case .timetable:
                return TimetableCell.height
            }
        }
        
        static var frozenColumns: Int {
            return 1
        }
        
        static var frozenRows: Int {
            return 1
        }
        
        static func numberOfColumns(_ count: Int) -> Int {
            return count + frozenColumns
        }
        
        static func numberOfRows(_ length: Int) -> Int {
            return length + frozenRows
        }
    }
    
}
