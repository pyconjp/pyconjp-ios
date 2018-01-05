//
//  MoreListViewController.swift
//  PyConJP
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class MoreListViewController: UITableViewController {
    
    private lazy var dataStore: MoreListDataStore = MoreListDataStore { [weak self] in
        DispatchQueue.main.async {
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table View Controller DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataStore.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataStore.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        cell.textLabel?.text = dataStore.sections[indexPath.section].rows[indexPath.row].title
        return cell
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = dataStore.sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .whatsPyConJP, .codeOfConduct, .summary, .license, .staffList:
            guard let identifier = row.identifier, let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        case .participantsInformation, .sponsor, .repository:
            guard let url = row.url else { return }
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        case .survey(let url):
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        case .conferenceMap:
            let mapListViewController = MapListViewController.build()
            self.navigationController?.pushViewController(mapListViewController, animated: true)
        case .sprintMap:
            let mapViewController = MapViewController.build(venue: MapViewController.Venue.microsoft)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        case .feedback:
            guard let urlSheme = row.urlSheme else { return }
            UIApplication.shared.open(urlSheme, options: [:], completionHandler: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
