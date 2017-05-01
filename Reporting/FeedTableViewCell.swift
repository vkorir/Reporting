//
//  FeedTableViewCell.swift
//  Reporting
//
//  Created by Victor Korir on 4/30/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!
    @IBOutlet weak var colorStrip: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
