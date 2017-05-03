//
//  FeedViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FeedViewController: UITableViewController {
    
    let postsRef = FIRDatabase.database().reference(withPath: Constants.posts)
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 165
        tableView.separatorColor = UIColor(colorLiteralRed: 240/255.0,
                                           green: 240/255.0,
                                           blue: 240/255.0,
                                           alpha: 1.0)

        postsRef.observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let post = Post(title: dictionary[Constants.title] as! String,
                            date: dictionary[Constants.date] as! String,
                            location: dictionary[Constants.location] as! String,
                            content: dictionary[Constants.content] as! String)
            post.setValuesForKeys(dictionary)
            self.posts.append(post)
            
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.feedCell, for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.title.text = post.title
        cell.time.text = "Date: " + post.date!
        cell.content.text = post.content
        cell.location.text = "Berkeley"
        
        cell.content.isUserInteractionEnabled = false
        cell.updateUI()
        cell.isUserInteractionEnabled = false
        return cell
    }
}
