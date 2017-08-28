//
//  EventsListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 8/27/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices
import WebAPIFramework

class EventsListViewController: UITableViewController {

    private let sections: [Section] = Section.sections
    
    // MARK: - Table View Controller DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text  = sections[indexPath.section].rows[indexPath.row].title
        return cell
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        let safariViewController = SFSafariViewController(url: URL(string: row.url)!)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
     private enum Section {
        case tutorialsDay
        case conferenseDay
        case sprintsDay
        
        static let sections: [Section] = [.tutorialsDay, .conferenseDay, .sprintsDay]
        
        var headerTitle: String {
            switch self {
            case .tutorialsDay:
                return "2017-09-07"
            case .conferenseDay:
                return "2017-09-08, 09"
            case .sprintsDay:
                return "2017-09-10"
            }
        }
        
        var rows: [Row] {
            switch self {
            case .tutorialsDay:
                return [.tutorials]
            case .conferenseDay:
                return [.keynote, .posters, .lightningTalks, .youthCoderWorkshop, .committeeMeeting, .communityBooth, .jobFair, .openSpace, .mediaMeeting]
            case .sprintsDay:
                return [.sprints]
            }
        }
        
    }
    
    private enum Row {
        case tutorials
        
        case keynote
        case posters
        case lightningTalks
        case youthCoderWorkshop
        case committeeMeeting
        case communityBooth
        case jobFair
        case openSpace
        case mediaMeeting
        
        case sprints
        
        var title: String {
            switch self {
            case .tutorials:
                return NSLocalizedString("tutorials", tableName: "EventList", comment: "")
            case .keynote:
                return NSLocalizedString("keynote", tableName: "EventList", comment: "")
            case .posters:
                return NSLocalizedString("posters", tableName: "EventList", comment: "")
            case .lightningTalks:
                return NSLocalizedString("lightningTalks", tableName: "EventList", comment: "")
            case .youthCoderWorkshop:
                return NSLocalizedString("youthCoderWorkshop", tableName: "EventList", comment: "")
            case .committeeMeeting:
                return NSLocalizedString("committeeMeeting", tableName: "EventList", comment: "")
            case .communityBooth:
                return NSLocalizedString("communityBooth", tableName: "EventList", comment: "")
            case .jobFair:
                return NSLocalizedString("jobFair", tableName: "EventList", comment: "")
            case .openSpace:
                return NSLocalizedString("openSpace", tableName: "EventList", comment: "")
            case .mediaMeeting:
                return NSLocalizedString("mediaMeeting", tableName: "EventList", comment: "")
            case .sprints:
                return NSLocalizedString("sprints", tableName: "EventList", comment: "")
            }
        }
        
        var url: String {
            switch self {
            case .tutorials:
                return WebConfig.baseURL + "events/tutorial/"
            case .keynote:
                return WebConfig.baseURL + "talks/keynote/"
            case .posters:
                return WebConfig.baseURL + "schedule/posters/list/"
            case .lightningTalks: 
                return WebConfig.baseURL + "events/lightning-talks/"
            case .youthCoderWorkshop:
                return WebConfig.baseURL + "events/youth-ws/"
            case .committeeMeeting:
                return WebConfig.baseURL + "events/committee-meeting/"
            case .communityBooth:
                return WebConfig.baseURL + "events/community/"
            case .jobFair:
                return WebConfig.baseURL + "events/jobsfair/"
            case .openSpace:
                return WebConfig.baseURL + "events/open-space/"
            case .mediaMeeting:
                return WebConfig.baseURL + "events/media-meeting/"
            case .sprints:
                return WebConfig.baseURL + "events/sprint/"
            }
        }
        
    }
}
