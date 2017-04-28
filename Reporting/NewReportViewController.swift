//
//  NewReportViewController.swift
//  Reporting
//
//  Created by Victor Korir on 4/28/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import GoogleMaps

class NewReportViewController: UIViewController {
    
    @IBOutlet weak var reportText: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var toMap: RoundButton!
    @IBOutlet weak var toFeed: RoundButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.addSubview(reportText)
        mapView.addSubview(submitButton)
        mapView.addSubview(toMap)
        mapView.addSubview(toFeed)
        
        self.view = mapView
    }
}
