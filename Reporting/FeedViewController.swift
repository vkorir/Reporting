//
//  FeedViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed"
        
        tableView.rowHeight = 145
        tableView.separatorColor = lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCell, for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        
        cell.title.text = pollutionOptions[post.titleIndex]
        cell.title.textColor = markerColors[post.titleIndex]
        cell.timeElapsed.text = post.getTimeElapsed()
        cell.postDescription.text = post.pollutionDescription
        cell.locationName.text = " " + "Berkeley"
        
        cell.postDescription.isUserInteractionEnabled = false
        cell.updateUI()
        cell.isUserInteractionEnabled = false
        return cell
    }
}
