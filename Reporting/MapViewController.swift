//
//  MapViewController.swift
//  Reporting
//
//  Created by Victor Korir on 4/28/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var newReport: RoundButton!
    @IBOutlet weak var feed: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.addSubview(appName)
        mapView.addSubview(aboutButton)
        mapView.addSubview(newReport)
        mapView.addSubview(feed)
        
        self.view = mapView
    }
}
