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
    @IBOutlet weak var userCount: RoundButton!
    let usersRef = FIRDatabase.database().reference(withPath: Constants.Online)
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        usersRef.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.userCount.setTitle(snapshot.childrenCount.description, for: .normal)
            } else {
                self.userCount.setTitle("0", for: .normal)
            }
        })

        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.addSubview(appName)
        mapView.addSubview(aboutButton)
        mapView.addSubview(newReport)
        mapView.addSubview(feed)
        mapView.addSubview(userCount)
        
        self.view = mapView
    }
}
