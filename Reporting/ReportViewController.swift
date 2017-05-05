//
//  ReportViewController.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import GoogleMaps
import GooglePlaces
import DLRadioButton

class ReportViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var bacgroundView: UIView!
    @IBOutlet weak var air: UIButton!
    @IBOutlet weak var water: UIButton!
    @IBOutlet weak var other: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var camera: RoundButton!
    @IBOutlet weak var submit: RoundButton!
    
    let postsRef = FIRDatabase.database().reference(withPath: postsPath)
    let imagesRef = FIRDatabase.database().reference(withPath: imagesPath)
    var manager: CLLocationManager!
    var places: GMSPlacesClient!
    var pollutionIndex: Int = 0
    var chosenImage: UIImage?
    var hideCamera: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Report"
        self.view.tintColor = greenTheme
        textView.delegate = self
        hideCamera = false
        
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
        textView.layer.cornerRadius = 3
        bacgroundView.backgroundColor = greenTheme.withAlphaComponent(0.2)
        bacgroundView.layer.cornerRadius = 3
        submit.backgroundColor = greenTheme
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude + 0.005, longitude: longitude, zoom: 12)
        map.camera = camera
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        places = GMSPlacesClient.shared()
        
        bacgroundView.layer.zPosition = 1
        
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bacgroundView.isHidden = false
        air.isSelected = false
        water.isSelected = false
        other.isSelected = false
        
        map.clear()
        let marker = GMSMarker()
        marker.position = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.map = map
        marker.icon = GMSMarker.markerImage(with: greenTheme)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
        }
        textView.resignFirstResponder()
    }
    
    @IBAction func selectedPollutionType(_ sender: DLRadioButton) {
        pollutionIndex = sender.tag
    }
    
    @IBAction func submitDidTouch(_ sender: RoundButton) {
        let lat = manager.location?.coordinate.latitude
        let lng = manager.location?.coordinate.longitude
        let location: [String: Double] = [latitudeKey: lat!, longitudeKey: lng!]
        
        if let postImage = chosenImage {
            let imgData = UIImageJPEGRepresentation(postImage, 1.0)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            let date = dateFormatter.string(from: Date())
            
            let postID = postsRef.childByAutoId()
            let storageRef = FIRStorage.storage().reference()
            let filePath = "\(imagesPath)/\(postID.key.description)"
            storageRef.child(filePath).put(imgData, metadata: nil, completion: { metadata, error in
                if let error = error {
                    print("Error uploading: \(error)")
                }
            })
            
            let properties: [String: AnyObject] = [
                pollutionIndexKey: pollutionIndex as AnyObject,
                dateKey: date as AnyObject,
                locationKey: location as AnyObject,
                descriptionKey: textView.text as AnyObject,
                imagePath: filePath as AnyObject
            ]
            postID.setValue(properties)
            
            let alert = UIAlertController(title: "Success!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Okay", style: .default) { action in
                self.bacgroundView.isHidden = true
                self.textView.text = nil
                self.view.endEditing(true)
                self.camera.isHidden = false
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
