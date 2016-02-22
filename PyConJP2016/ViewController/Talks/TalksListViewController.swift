//
//  TalksListViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/02/21.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit

class TalksListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
//    var roomNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib  = UINib(nibName: "TalkTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"TalkTableViewCell")
        
        tableView.estimatedRowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TalkTableViewCell") as? TalkTableViewCell
        return cell!
    }

}
