//
//  AboutViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import FirebaseAuth

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "About"
        self.navigationController?.navigationBar.tintColor = greenTheme
    }
}
