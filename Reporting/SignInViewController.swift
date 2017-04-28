//
//  SignInViewController.swift
//  Reporting
//
//  Created by Victor Korir on 4/28/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func loginDidTouch(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.SignInToMap, sender: nil)
    }
}
