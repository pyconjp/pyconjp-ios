//
//  ConferenceViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 8/27/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class ConferenceViewController: UIViewController {
    
    @IBAction func onBookmark(_ sender: UIBarButtonItem) {
        let bookmarkListViewController = BookmarkListViewController.build()
        self.navigationController?.pushViewController(bookmarkListViewController, animated: true)
    }
    
}
