//
//  FeedTableViewCell.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundCardView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var location: UILabel!
    
    func updateUI() {
        backgroundCardView.backgroundColor = UIColor.white
        backgroundCardView.layer.cornerRadius = 3.0
        backgroundCardView.layer.masksToBounds = false
        backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCardView.layer.shadowOpacity = 0.8
        
        contentView.backgroundColor = UIColor(colorLiteralRed: 240/255.0,
                                              green: 240/255.0,
                                              blue: 240/255.0,
                                              alpha: 1.0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
