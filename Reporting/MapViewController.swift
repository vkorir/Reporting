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

    @IBOutlet weak var newReport: UIButton!
    @IBOutlet weak var feed: RoundButton!
    @IBOutlet weak var userCount: RoundButton!
    @IBOutlet weak var newReportLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var feedLabel: UILabel!
    let usersRef = FIRDatabase.database().reference(withPath: Constants.Online)
    let locationManager = CLLocationManager()
    var user: User!
    
    var appName: UILabel!
    var aboutButton: UIButton!
    
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
                self.userCount.setTitle(snapshot.childrenCount.description, for: .normal)
            } else {
                self.userCount.setTitle("0", for: .normal)
            }
        })
        
        self.locationManager.requestWhenInUseAuthorization()
        //Adding a map
        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let dim = view.bounds
        
        appName = UILabel(frame: CGRect(x: 5, y: 40, width: 100, height: 30))
        appName.textAlignment = .left
        appName.text = "Reporting"
        
        aboutButton = UIButton(frame: CGRect(x: dim.width - 60, y: 40, width: 60, height: 30))
        aboutButton.setTitle("About", for: .normal)
        aboutButton.setTitleColor(view.tintColor, for: .normal)
        aboutButton.addTarget(self, action: #selector(aboutDidTouch(sender:)), for: .touchUpInside)
        
        newReport.frame = CGRect(x: (dim.width / 3) - 25, y: dim.height * 3/4, width: 50, height: 50)
        newReportLabel.frame = CGRect(x: (dim.width / 3) - 35, y: dim.height * 3/4 + 55, width: 70, height: 10)
        userCount.frame = CGRect(x: (dim.width / 2) - 25, y: dim.height * 3/4, width: 50, height: 50)
        onlineLabel.frame = CGRect(x: (dim.width / 2) - 25, y: dim.height * 3/4 + 55, width: 50, height: 10)
        feed.frame = CGRect(x: (dim.width * 2 / 3) - 25, y: dim.height * 3/4, width: 50, height: 50)
        feedLabel.frame = CGRect(x: (dim.width * 2 / 3) - 25, y: dim.height * 3/4 + 55, width: 50, height: 10)
        
        newReport.layer.shadowColor = UIColor.darkGray.cgColor
        newReport.layer.shadowOffset = CGSize(width: 5, height: 5)
        newReport.layer.shadowRadius = 5
        newReport.layer.shadowOpacity = 0.8
        
        userCount.layer.shadowColor = UIColor.darkGray.cgColor
        userCount.layer.shadowOffset = CGSize(width: 5, height: 5)
        userCount.layer.shadowRadius = 5
        userCount.layer.shadowOpacity = 0.8
        
        feed.layer.shadowColor = UIColor.darkGray.cgColor
        feed.layer.shadowOffset = CGSize(width: 5, height: 5)
        feed.layer.shadowRadius = 5
        feed.layer.shadowOpacity = 0.8
        
        mapView.addSubview(appName)
        mapView.addSubview(aboutButton)
        mapView.addSubview(newReport)
        mapView.addSubview(feed)
        mapView.addSubview(userCount)
        mapView.addSubview(newReportLabel)
        mapView.addSubview(onlineLabel)
        mapView.addSubview(feedLabel)
        
//        mapView.settings.compassButton = true
//        mapView.settings.myLocationButton = true
        
//        mapView.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
        
//        DispatchQueue.main.async(execute: { () -> Void in
//            mapView.isMyLocationEnabled = true
//        })
        
        self.view = mapView
    }
    
    func aboutDidTouch(sender: UIButton!) {
        self.performSegue(withIdentifier: Constants.MapToAbout, sender: nil)
    }
    @IBAction func toNewDidTouch(_ sender: UIButton) {
        NewReportViewController.caller = Constants.NewToMap
        self.performSegue(withIdentifier: Constants.MapToNew, sender: nil)
    }
}
