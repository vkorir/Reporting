//
//  RoundButton.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.lightGray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3, height: 3) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
}
