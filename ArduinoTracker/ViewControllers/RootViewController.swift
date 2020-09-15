//
//  RootViewController.swift
//  ArduinoTracker
//
//  Created by Rob Piccirillo on 9/14/20.
//  Copyright © 2020 Rob Piccirillo. All rights reserved.
//

import UIKit

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

    @IBAction func loginPressed(_ sender: Any) {
    }
}
