//
//  File.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import Foundation

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
}
