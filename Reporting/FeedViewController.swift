//
//  FeedViewController.swift
//  Reporting
//
//  Created by Victor Korir on 4/28/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let postsRef = FIRDatabase.database().reference(withPath: Constants.Posts)
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func toNewDidTouch(_ sender: RoundButton) {
        NewReportViewController.caller = "NewToFeed"
        self.performSegue(withIdentifier: Constants.FeedToNew, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.feedCell, for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.title.text = post.title
        cell.timeElapsed.text = "1 minute ago"
        cell.postDescription.text = post.content
        cell.location.text = post.location
        return cell
    }
}
