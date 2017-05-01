//
//  NewReportViewController.swift
//  Reporting
//
//  Created by Victor Korir on 4/28/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import DLRadioButton

class NewReportViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pollutionLabel: UILabel!
    @IBOutlet weak var airSelection: DLRadioButton!
    @IBOutlet weak var waterSelection: DLRadioButton!
    @IBOutlet weak var otherSelection: DLRadioButton!
    @IBOutlet weak var reportText: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    let postsRef = FIRDatabase.database().reference(withPath: Constants.Posts)
    var pollution: String = ""
    public static var caller: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reportText.text = "Incident description..."
        reportText.textColor = UIColor.lightGray
        reportText.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: Constants.latitude,
                                              longitude: Constants.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let dim = view.bounds
        scrollView.frame = CGRect(x: 5, y: 20, width: dim.width - 10, height: 250)
        scrollView.layer.cornerRadius = 5
        pollutionLabel.frame = CGRect(x: 10, y: 40, width: 90, height: 30)
        airSelection.frame = CGRect(x: dim.width / 3, y: 40, width: 60, height: 30)
        waterSelection.frame = CGRect(x: dim.width / 3 + 70, y: 40, width: 60, height: 30)
        otherSelection.frame = CGRect(x: dim.width / 3 + 140, y: 40, width: 60, height: 30)
        reportText.frame = CGRect(x: 10, y: 80, width: dim.width - 30, height: 90)
        submitButton.frame = CGRect(x: dim.width / 2 - 45, y: 200, width: 90, height: 30)
//        toMap.frame = CGRect(x: dim.width / 3 - 25, y: dim.height * 3 / 4, width: 50, height: 50)
//        toFeed.frame = CGRect(x: dim.width * 2 / 3 - 25, y: dim.height * 3 / 4, width: 50, height: 50)
        
        mapView.addSubview(scrollView)
//        mapView.addSubview(toMap)
//        mapView.addSubview(toFeed)
        
        self.view = mapView
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
    
    @IBAction func radioAir(_ sender: DLRadioButton) {
        pollution = "Air"
    }
    
    @IBAction func radioWater(_ sender: DLRadioButton) {
        pollution = "Water"
    }
    
    @IBAction func radioOther(_ sender: DLRadioButton) {
        pollution = "Other"
    }
    
    @IBAction func submitDidTouch(_ sender: UIButton) {
        let post: [String: Any] = [
            Constants.title: pollution,
            Constants.date: Date().description,
            Constants.location: "Berkeley",
            Constants.content: reportText.text
        ]
        self.postsRef.childByAutoId().setValue(post)
        reportText.text = "Incident description..."
        reportText.textColor = UIColor.lightGray
        
        let alert = UIAlertController(title: "Success!", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default) { action in
            self.performSegue(withIdentifier: NewReportViewController.caller, sender: nil)
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
