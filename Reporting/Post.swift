//
//  File.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import GoogleMaps

class Post {
    let titleIndex: Int
    let date: Date
    let location: [String: Double]
    let pollutionDescription: String
    let imagePath: String
    let geocoder: GMSGeocoder!
    
    init(titleIndex: Int, dateString: String, location: [String: Double], description: String, imagePath: String) {
        self.titleIndex = titleIndex
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        self.date = dateFormatter.date(from: dateString)!
        self.location = location
        self.pollutionDescription = description
        self.geocoder = GMSGeocoder()
        self.imagePath = imagePath
    }
    
    func getTimeElapsed() -> String {
        let secondsSincePosted = -date.timeIntervalSinceNow
        let minutes = Int(secondsSincePosted / 60)
        if minutes == 1 {
            return "\(minutes) minute ago"
        } else if minutes < 60 {
            return "\(minutes) minutes ago "
        } else if minutes < 120 {
            return "1 hour ago"
        } else if minutes < 24 * 60 {
            return "\(minutes / 60) hours ago"
        } else if minutes < 48 * 60 {
            return "1 day ago"
        } else {
            return "\(minutes / 1440) days ago"
        }
        
    }
    
    func getPlaceName() -> String {
        let randomNames = ["1903 Haste St", "2520-2336 Hearst Ave", "Hilgard Hall", "Ridge Path", " Bear Chix Bootcamp", "Strawberry Creek",
                            "Grinnell Pathway", "West Cir", "2123 Oxford St", "1823 Berkeley Way", "2557 Le Conte Ave", "Hearst Memorial Gymnasium",
                            "Free Speech Bikeway", "Jacobs Hall", "S Hall rd", "UC Berkeley"]
        return randomNames[Int(arc4random_uniform(UInt32(randomNames.count)))]
    }
    
    func getDistance() -> String {
        let from = CLLocation(latitude: latitude, longitude: longitude)
        let to = CLLocation(latitude: location[latitudeKey]!, longitude: location[longitudeKey]!)
        let meters = to.distance(from: from)
        let miles = meters * 0.000621371
        
        if meters < 100 {
            return "< \(meters) meters"
        } else if (miles * 10.0).rounded() / 10.0 == 1.0  {
            return "< \(1) mile"
        } else if miles < 10 {
            return "< \((miles * 10.0).rounded() / 10.0) miles"
        } else if miles < 100 {
            return"< \(Int((miles / 10.0).rounded() * 10.0) + 10) miles"
        } else {
            return "> \(100) miles"
        }
    }
    
    func getImage(completion: @escaping (Data?) -> Void) {
        let storageRef = FIRStorage.storage().reference()
        storageRef.child(self.imagePath).data(withMaxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
}
