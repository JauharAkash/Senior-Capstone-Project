//
//  RootViewController.swift
//  ArduinoTracker
//
//  Created by Rob Piccirillo on 9/14/20.
//  Copyright © 2020 Rob Piccirillo. All rights reserved.
//

import UIKit
import FirebaseAuth

class RootViewController: UIViewController {

    private var MapViewController: MapViewController!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeElements()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeElements() {
        
        //Utilities.styleTextField(emailTextField)
        
        //Utilities.styleTextField(passwordTextField)
        
        // Utilities.styleFilledButton(loginButton )
    }
    
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        
    }
    
    // Check to make sure all fields were filled out correctly.
//    func verifyFields() -> String? {
//
//        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//
//            return "Please fill in all fields."
//        }
//
//    }

    @IBAction func loginPressed(_ sender: Any) {
       
        // TODO: Verify Login Information
       //let error = verifyFields()
        
        // Create clean versions of the fields
        let emailAddress = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign In User
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (result, error) in
        
        if error != nil  {
            // Couldn't sign in
            self.loginLabel.text = "No Password."
        }
        
        else {
            let MapViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.MapViewController) as? MapViewController
            
            self.view.window?.rootViewController = MapViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        }
    }
}
