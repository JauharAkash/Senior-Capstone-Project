//
//  SignUpViewController.swift
//  ArduinoTracker
//
//  Created by Rob Piccirillo on 9/14/20.
//  Copyright © 2020 Rob Piccirillo. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var arduinoIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Check fields to validate that the data is correct. If everything is correct, return nil. If not, return error.
    func verifyFields() -> String? {
        // Check that all fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || arduinoIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields!"
            
        }
         
        // Check that password is secure enough
        let properPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordCorrect(properPassword) == false {
            // Password not good enough
            return "Please make sure your password is at least eight characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        
        // Validate fields
        let error = verifyFields()
        
        if error != nil {
            // There's something wrong with the fields, show error
            showError(error!)
        }
        
        else {
            
            // Create cleaned versions of the text fields
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailAddress = emailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let arduinoID = arduinoIDTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
        // Create user
            Auth.auth().createUser(withEmail: emailAddress, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    // There's an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    // User created successfully
                    let db = Firestore.firestore()
                    
                    db.collection("userInfo").addDocument(data: ["firstName": firstName, "lastName": lastName, "emailAddress":emailAddress, "password":password, "arduinoID":arduinoID, "userID":result!.user.uid]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("User saving user data")
                        }
                    }
                    
                }
            }

        // Transition to the home screen
            self.transitionToMap()

        }
        
    }
    
    func showError(_ message: String) {
        
        signUpLabel.text = message
    }
    
    func transitionToMap() {
        let MapViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.MapViewController) as? MapViewController
        
        self.view.window?.rootViewController = MapViewController
        self.view.window?.makeKeyAndVisible()
    }

}
