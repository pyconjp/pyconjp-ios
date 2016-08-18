//
//  ScheduleListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/06/13.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleListDataSource: NSObject, UITableViewDataSource, TimelineDataSource {
    
    var timelines: [Timeline] = []
    
    let filterPredicate: NSPredicate
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    init(day: String?) {
        self.filterPredicate = day != nil ? NSPredicate(format: "day == %@", day!) : NSPredicate()
        super.init()
    }
    
    func refreshData() {
        timelines.removeAll()
        loadTalkObjects { result in
            switch result {
            case .Success(let talks):
                let keys = talks.map { $0.startTime }.unique()
                for tuple in keys.enumerate() {
                    self.timelines.append(Timeline(time: keys[tuple.index], talks: talks.filter { $0.startTime == keys[tuple.index]}))
                }
            case .Failure: break
            }
        }
    }
    
    // MARK: - Table View Controller Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return timelines.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return timelines[section].key
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelines[section].talks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? TalkTableViewCell else {
            fatalError("Could not create ScheduleListTableViewCell")
        }
        cell.fillWith(timelines[indexPath.section].talks[indexPath.row])
        return cell
    }
}
