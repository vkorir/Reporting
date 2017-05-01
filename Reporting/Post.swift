//
//  Post.swift
//  Reporting
//
//  Created by Victor Korir on 4/30/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit

class Post: NSObject {
    var title: String?
    var date: String?
    var location: String?
    var content: String?
    
    init(title: String, date: String, location: String, content: String) {
        self.title = title
        self.date = date
        self.location = location
        self.content = content
    }
    
//    func getTimeElaspsedString() -> String {
//        let secondsSincePosted = -(date?.timeIntervalSinceNow)!
//        let minutes = Int(secondsSincePosted / 60)
//        if minutes == 1 {
//            return "\(minutes) minute ago"
//        } else if minutes < 60 {
//            return "\(minutes) minutes ago "
//        } else if minutes < 120 {
//            return "1 hour ago"
//        } else if minutes < 24 * 60 {
//            return "\(minutes / 60) hours ago"
//        } else if minutes < 48 * 60 {
//            return "1 day ago"
//        } else {
//            return "\(minutes / 1440) days ago"
//        }
//
//    }
}
