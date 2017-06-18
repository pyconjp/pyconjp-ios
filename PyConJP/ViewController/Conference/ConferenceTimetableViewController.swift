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
    
    fileprivate var dataStore: ConferenceTimetableDataStore?
    
    static func build(_ pyconJPDate: PyConJPDate) -> ConferenceTimetableViewController {
        let viewController: ConferenceTimetableViewController = UIStoryboard(storyboard: .conference).instantiateViewController()
        viewController.dataStore = ConferenceTimetableDataStore(day: pyconJPDate.description)
        return viewController
    }

}

extension ConferenceTimetableViewController: SpreadsheetViewDataSource {
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 0
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 0
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 0
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: TimetableCell.nibName, for: indexPath)
        return cell
    }
    
//    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
//        <#code#>
//    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
}
