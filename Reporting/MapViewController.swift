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

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var map: GMSMapView!
    var usersRef = FIRDatabase.database().reference(withPath: onlinePath)
    let postsRef = FIRDatabase.database().reference(withPath: postsPath)
    var user: User!
    var mapView: GMSMapView!
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        self.navigationItem.title = "Reporting"
        
        //Firebase authorization listener
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        postsRef.observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let post = Post(titleIndex: dictionary[pollutionIndexKey] as! Int,
                            dateString: dictionary[dateKey] as! String,
                            location: dictionary[locationKey] as! [String: Double],
                            description: dictionary[descriptionKey] as! String)
            posts.append(post)
            
            let lat: Double = post.location[latitudeKey]!
            let lng: Double = post.location[longitudeKey]!
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            marker.title = pollutionOptions[post.titleIndex]
            marker.snippet = "latitude: \(lat) longitude: \(lng)"
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.icon = GMSMarker.markerImage(with: markerColors[post.titleIndex])
            marker.map = self.map
        })
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12)
        map.camera = camera
        map.isMyLocationEnabled = true
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
