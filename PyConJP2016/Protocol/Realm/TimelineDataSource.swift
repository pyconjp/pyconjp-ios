//
//  TimelineDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/08/18.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import RealmSwift

protocol TimelineDataSource {
    var reuseIdentifier: String { get }
    var timelines: Array<Timeline> { get set }
    var filterPredicate: NSPredicate { get }
    var sortProperties: Array<SortDescriptor> { get }
    
    func loadTalkObjects(completionHandler: (Result<Array<TalkObject>, NSError> -> Void)) -> Void
}

extension TimelineDataSource {
    
    var reuseIdentifier: String {
        return "TalkTableViewCell"
    }
    
    func loadTalkObjects(completionHandler: (Result<Array<TalkObject>, NSError> -> Void)) -> Void {
        do {
            let realm = try Realm()
            let talks = realm.objects(TalkObject).filter(filterPredicate).sorted(sortProperties).map { $0 }
            completionHandler(.Success(talks))
        } catch let error as NSError {
            completionHandler(.Failure(error))
        }
    }

}
