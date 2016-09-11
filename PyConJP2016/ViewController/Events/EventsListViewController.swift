//
//  EventsListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/27/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class EventsListViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return }
        let rowType = sectionType.rows[indexPath.row]
        let safariViewController = SFSafariViewController(URL: NSURL(string: rowType.url)!)
        self.presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    private enum SectionType: Int {
        case TutorialsDay
        case ConferenseDay
        case SprintsDay
        
        var rows: Array<RowType> {
            switch self {
            case .TutorialsDay:
                return [.Tutorial]
            case .ConferenseDay:
                return [.Keynote, .InvitedLecture, .Posters, .JobsFair, .ProductsFair]
            case .SprintsDay:
                return [.Sprints]
            }
        }
        
    }
    
    private enum RowType {
        case Tutorial
        
        case Keynote
        case InvitedLecture
        case Posters
        case JobsFair
        case ProductsFair
        
        case Sprints
        
        var url: String {
            switch self {
            case .Tutorial: return PCJConfig.baseURL + "events/tutorial/"
            case .Keynote: return PCJConfig.baseURL + "keynote/"
            case .InvitedLecture: return PCJConfig.baseURL + "talks/invited-speaker/"
            case .Posters: return PCJConfig.baseURL + "schedule/posters/list/"
            case .JobsFair: return PCJConfig.baseURL + "events/jobsfair/"
            case .ProductsFair: return PCJConfig.baseURL + "productfair/"
            case .Sprints: return PCJConfig.baseURL + "events/sprint/"
            }
        }
        
    }
}
