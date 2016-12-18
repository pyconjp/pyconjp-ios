//
//  EventsListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/27/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import WebAPIFramework
import SafariServices

class EventsListViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: (indexPath as NSIndexPath).section) else { return }
        let rowType = sectionType.rows[(indexPath as NSIndexPath).row]
        let safariViewController = SFSafariViewController(url: URL(string: rowType.url)!)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    private enum SectionType: Int {
        case tutorialsDay
        case conferenseDay
        case sprintsDay
        
        var rows: Array<RowType> {
            switch self {
            case .tutorialsDay:
                return [.tutorial]
            case .conferenseDay:
                return [.keynote, .invitedLecture, .posters, .lightningTalks, .youthCoderWorkshop, .beginnerSession, .committeeMeeting, .communityBooth, .jobFair, .productFair, .openSpace]
            case .sprintsDay:
                return [.sprints]
            }
        }
        
    }
    
    private enum RowType {
        case tutorial
        
        case keynote
        case invitedLecture
        case posters
        case lightningTalks
        case youthCoderWorkshop
        case beginnerSession
        case committeeMeeting
        case communityBooth
        case jobFair
        case productFair
        case openSpace
        
        case sprints
        
        var url: String {
            switch self {
            case .tutorial: return WebConfig.baseURL + "events/tutorial/"
            case .keynote: return WebConfig.baseURL + "keynote/"
            case .invitedLecture: return WebConfig.baseURL + "talks/invited-speaker/"
            case .posters: return WebConfig.baseURL + "schedule/posters/list/"
            case .lightningTalks: return WebConfig.baseURL + "events/lightning-talks/"
            case .youthCoderWorkshop: return WebConfig.baseURL + "events/youth-ws/"
            case .beginnerSession: return WebConfig.baseURL + "events/beginners/"
            case .committeeMeeting: return WebConfig.baseURL + "events/committee-meeting/"
            case .communityBooth: return WebConfig.baseURL + "events/community-booth/"
            case .jobFair: return WebConfig.baseURL + "events/jobsfair/"
            case .productFair: return WebConfig.baseURL + "productfair/"
            case .openSpace: return WebConfig.baseURL + "events/open-space/"
            case .sprints: return WebConfig.baseURL + "events/sprint/"
            }
        }
        
    }
}
