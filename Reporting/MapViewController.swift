//
//  MapViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var about: UIButton!
    @IBOutlet weak var toReport: RoundButton!
    @IBOutlet weak var toUsers: RoundButton!
    @IBOutlet weak var toFeed: RoundButton!
    @IBOutlet weak var report: UILabel!
    @IBOutlet weak var users: UILabel!
    @IBOutlet weak var feed: UILabel!
    
    var usersRef = FIRDatabase.database().reference(withPath: Constants.online)
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Firebase authorization listener
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        usersRef.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.toUsers.setTitle(snapshot.childrenCount.description, for: .normal)
            } else {
                self.toUsers.setTitle("0", for: .normal)
            }
        })
        
        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        mapView.addSubview(appName)
        mapView.addSubview(about)
        mapView.addSubview(toReport)
        mapView.addSubview(toUsers)
        mapView.addSubview(toFeed)
        mapView.addSubview(report)
        mapView.addSubview(users)
        mapView.addSubview(feed)
        
        self.view = mapView
    }
}
