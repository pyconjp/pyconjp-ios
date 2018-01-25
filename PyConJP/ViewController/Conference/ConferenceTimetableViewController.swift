//
//  ConferenceTimetableViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 2017/06/17.
//  Copyright © 2017 PyCon JP. All rights reserved.
//

import UIKit
import SpreadsheetView

final class ConferenceTimetableViewController: UIViewController, StoryboardIdentifiable {
    
    @IBOutlet weak var timetableView: SpreadsheetView! {
        didSet {
            timetableView.dataSource = self
            timetableView.delegate = self
            timetableView.register(TimetableCell.nib, forCellWithReuseIdentifier: TimetableCell.nibName)
            timetableView.register(TimetableRoomCell.nib, forCellWithReuseIdentifier: TimetableRoomCell.nibName)
            timetableView.register(TimetableTimeAxisCell.nib, forCellWithReuseIdentifier: TimetableTimeAxisCell.nibName)
            timetableView.gridStyle = .none
        }
    }
    fileprivate(set) var dataStore: ConferenceTimetableDataStore?
    
    static func build(_ pyconJPDate: PyConJPDate) -> ConferenceTimetableViewController {
        let viewController: ConferenceTimetableViewController = UIStoryboard(storyboard: .conference).instantiateViewController()
        viewController.dataStore = ConferenceTimetableDataStore(pyconJPDate: pyconJPDate)
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    @objc func refreshNotification(_ notification: Notification) {
        refresh()
    }
    
    private func refresh() {
        dataStore?.reloadTimetable()
        timetableView.reloadData()
    }

}

extension ConferenceTimetableViewController: SpreadsheetViewDataSource {
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return dataStore?.numberOfColumns() ?? 0
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return dataStore?.numberOfRows() ?? 0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return dataStore?.widthForColumn(column) ?? 0.0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return dataStore?.heightForRow(row) ?? 0.0
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let section = ConferenceTimetableDataStore.Section(indexPath: indexPath)
        guard let cellIdentifier = dataStore?.cellIdentifier(indexPath) else { return nil }
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        switch (section, cell) {
        case (.rowHeader, let roomCell as TimetableRoomCell):
            guard let room = dataStore?.room(indexPath) else { return nil }
            roomCell.fill(room)
            return cell
        case (.columnHeader, let timeCell as TimetableTimeAxisCell):
            guard let hourClock = dataStore?.hourClock(indexPath) else { return nil }
            timeCell.fill(hourClock)
            return timeCell
        case (.timetable, let timetableCell as TimetableCell):
            guard let talkObject = dataStore?.talk(indexPath) else { return nil }
            timetableCell.fill(talkObject)
            return timetableCell
        default:
            return nil
        }
    }
    
    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        var mergedCells = [CellRange]()
        // TimeAxis
        guard let hourDuration = dataStore?.timetable.hourDuration else { return mergedCells }
        for hour in hourDuration.enumerated() {
            mergedCells.append(CellRange(from: (row: 60 * hour.offset + 1, column: 0),
                                         to: (row: 60 * (hour.offset + 1), column: 0)))
        }
        // Talks
        guard let start = dataStore?.start else { return mergedCells }
        dataStore?.timetable.tracks.enumerated().forEach({ column, track in
            track.talks.forEach({ talk in
                let startTime = Int(talk.startDate.timeIntervalSince(start) / 60)
                mergedCells.append(CellRange(from: (row: startTime + 1, column: column + 1),
                                             to: (row: startTime + talk.minutesDuration, column: column + 1)))
            })
        })
        
        return mergedCells
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return dataStore?.frozenColumns ?? 0
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return dataStore?.frozenRows ?? 0
    }
    
}

extension ConferenceTimetableViewController: SpreadsheetViewDelegate {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        let section = ConferenceTimetableDataStore.Section(indexPath: indexPath)
        switch section {
        case .corner, .rowHeader, .columnHeader:
            break
        case .timetable:
            guard let talkObject = dataStore?.talk(indexPath) else { return }
            let talkDetailViewController = TalkDetailViewController.build(id: talkObject.id)
            navigationController?.pushViewController(talkDetailViewController, animated: true)
        }
    }
    
}
