//
//  SignInViewController.swift
//  Reporting
//
//  Created by Victor Korir on 4/28/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: Constants.SignInToMap, sender: nil)
            }
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
        
        let dim = view.bounds
        let width = dim.width * 3/5
        appName.frame = CGRect(x: 0.5 * (dim.width - width), y: 0.25 * dim.height, width: width, height: 30)
        emailTextField.frame = CGRect(x: 0.5 * (dim.width - width), y: 0.5 * dim.height, width: width, height: 30)
        passwordTextField.frame = CGRect(x: 0.5 * (dim.width - width), y: 0.5 * dim.height + 40, width: width, height: 30)
        signUpButton.frame = CGRect(x: 0.5 * (dim.width - width), y: 0.5 * dim.height + 80, width: width / 2 - 3, height: 30)
        logInButton.frame = CGRect(x: dim.width / 2 + 3, y: 0.5 * dim.height + 80, width: width / 2 - 3, height: 30)
    }
    
    @IBAction func loginDidTouch(_ sender: UIButton) {
        FIRAuth.auth()!.signIn(withEmail: emailTextField.text!,
                               password: passwordTextField.text!)
    }
    
    @IBAction func signUpDidTouch(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: nil,
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Create",
                                       style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                       password: passwordField.text!) { user, error in
                                        if error == nil {
                                            FIRAuth.auth()!.signIn(withEmail: self.emailTextField.text!,
                                                                   password: self.passwordTextField.text!)
                                        }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func dismissKeyBoard() {
        view.endEditing(true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
