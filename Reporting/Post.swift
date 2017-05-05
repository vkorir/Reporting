//
//  File.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import Foundation
import UIKit

class Post {
    let titleIndex: Int
    let date: Date
    let location: [String: Double]
    let pollutionDescription: String
    
    init(titleIndex: Int, dateString: String, location: [String: Double], description: String) {
        self.titleIndex = titleIndex
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.date = dateFormatter.date(from: dateString)!
        self.location = location
        self.pollutionDescription = description
    }
    
    func getTimeElapsed() -> String {
        let secondsSincePosted = -date.timeIntervalSinceNow
        let minutes = Int(secondsSincePosted / 60)
        if minutes == 1 {
            return "\(minutes) minute ago"
        } else if minutes < 60 {
            return "\(minutes) minutes ago "
        } else if minutes < 120 {
            return "1 hour ago"
        } else if minutes < 24 * 60 {
            return "\(minutes / 60) hours ago"
        } else if minutes < 48 * 60 {
            return "1 day ago"
        } else {
            return "\(minutes / 1440) days ago"
        }
        
    }
}
