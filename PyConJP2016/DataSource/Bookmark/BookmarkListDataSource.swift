//
//  BookmarkListDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarkListDataSource: NSObject, UITableViewDataSource, TimelineDataSource {
    
    var timelines: [Timeline] = []
    
    let filterPredicate = NSPredicate(format: "favorited == %@", true)
    let sortProperties = [SortDescriptor(property: "date", ascending: true), SortDescriptor(property: "place", ascending: true)]
    
    func refreshData() {
        timelines.removeAll()
        loadTalkObjects({ result in
            switch result {
            case .Success(let talks):
                let keys = talks.map { $0.day }.unique()
                for tuple in keys.enumerate() {
                    self.timelines.append(Timeline(key: keys[tuple.index], talks: talks.filter { $0.day == keys[tuple.index]}))
                }
                break
            case .Failure: break
            }
        })
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
