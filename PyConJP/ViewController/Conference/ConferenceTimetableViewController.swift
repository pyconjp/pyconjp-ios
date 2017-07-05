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
            timetableView.register(TimetableCell.nib, forCellWithReuseIdentifier: TimetableCell.nibName)
            timetableView.register(TimetableRoomCell.nib, forCellWithReuseIdentifier: TimetableRoomCell.nibName)
            timetableView.register(TimetableTimeAxisCell.nib, forCellWithReuseIdentifier: TimetableTimeAxisCell.nibName)
        }
    }
    fileprivate(set) var dataStore: ConferenceTimetableDataStore?
    
    static func build(_ pyconJPDate: PyConJPDate) -> ConferenceTimetableViewController {
        let viewController: ConferenceTimetableViewController = UIStoryboard(storyboard: .conference).instantiateViewController()
        viewController.dataStore = ConferenceTimetableDataStore(pyconJPDate: pyconJPDate)
        return viewController
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
            guard let room = dataStore?.room(indexPath) else { return cell }
            roomCell.fill(room)
            return cell
        case (.columnHeader, let timeCell as TimetableTimeAxisCell):
            return timeCell
        case (.timetable, let timetableCell as TimetableCell):
            return timetableCell
        default:
            return nil
        }
    }
    
    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        var mergedCells = [CellRange]()
        // TimeAxis
        for row in 0..<(dataStore?.timetable.hours ?? 0) {
            mergedCells.append(CellRange(from: (60 * row + 1, 0), to: (60 * (row + 1), 0)))
        }
        mergedCells.append(CellRange(from: (row: 60 * (dataStore?.timetable.hours ?? 0) + 1, column: 0),
                           to: (row: 60 * (dataStore?.timetable.hours ?? 0) + (dataStore?.timetable.fractionMinutes ?? 0), column: 0)))
        return mergedCells
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
}
