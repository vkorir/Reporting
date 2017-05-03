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

    @IBOutlet weak var air: UIButton!
    @IBOutlet weak var water: UIButton!
    @IBOutlet weak var other: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var submit: RoundButton!
    
    let postsRef = FIRDatabase.database().reference(withPath: Constants.posts)
    var pollution: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = "Descibe incident..."
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        
//        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
//                                              longitude: Constants.longitude,
//                                              zoom: 12)
//        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
//        mapView.addSubview(submit)
        
//        self.view = mapView
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Incident description..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func didSelectAirt(_ sender: DLRadioButton) {
        pollution = "Air"
    }
    
    @IBAction func didSelectWater(_ sender: DLRadioButton) {
        pollution = "Water"
    }
    
    @IBAction func didSelectOther(_ sender: DLRadioButton) {
        pollution = "Other"
    }
    
    @IBAction func submitDidTouch(_ sender: RoundButton) {
        let post: [String: Any] = [
            Constants.title: pollution,
            Constants.date: Date().description,
            Constants.location: "Berkeley",
            Constants.content: textView.text
        ]
        self.postsRef.childByAutoId().setValue(post)
        textView.text = "Incident description..."
        textView.textColor = UIColor.lightGray
        
        let alert = UIAlertController(title: "Success!", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
