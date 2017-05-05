//
//  ReportViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMaps
import DLRadioButton

class ReportViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var bacgroundView: UIView!
    @IBOutlet weak var air: UIButton!
    @IBOutlet weak var water: UIButton!
    @IBOutlet weak var other: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submit: RoundButton!
    
    let postsRef = FIRDatabase.database().reference(withPath: postsPath)
    var manager: CLLocationManager!
    var pollutionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Report"
        self.view.tintColor = greenTheme
        
        textView.delegate = self
        
        bacgroundView.backgroundColor = greenTheme
        bacgroundView.layer.cornerRadius = 3
        submit.backgroundColor = UIColor.clear
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 12)
        map.camera = camera
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        bacgroundView.layer.zPosition = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bacgroundView.isHidden = false
        air.isSelected = false
        water.isSelected = false
        other.isSelected = false
        
        map.clear()
        let marker = GMSMarker()
        marker.position = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "UC Berkeley"
        marker.map = map
        marker.icon = GMSMarker.markerImage(with: greenTheme)
    }
    
    @IBAction func selectedPollutionType(_ sender: DLRadioButton) {
        pollutionIndex = sender.tag
    }
    
    @IBAction func submitDidTouch(_ sender: RoundButton) {
        let lat = manager.location?.coordinate.latitude
        let lng = manager.location?.coordinate.longitude
        let location: [String: Double] = [latitudeKey: lat!, longitudeKey: lng!]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from: Date())
        let properties: [String: AnyObject] = [
            pollutionIndexKey: pollutionIndex as AnyObject,
            dateKey: date as AnyObject,
            locationKey: location as AnyObject,
            descriptionKey: textView.text as AnyObject
        ]
        postsRef.childByAutoId().setValue(properties)
        
        let alert = UIAlertController(title: "Success!", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default) { action in
            self.bacgroundView.isHidden = true
            self.textView.text = nil
            self.view.endEditing(true)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
