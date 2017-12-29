//
//  ViewController.swift
//  InstaProject
//
//  Created by my mac on 12/5/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func onLoginTapped(_ sender: UIButton) {
        print("onLoginTapped()")
        
        
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            print("One of the fields was empty.")
            return
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if user != nil {
               print("Yay user logged in.")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
        
        
    }
    
    
    
    @IBAction func onSignUpTapped(_ sender: UIButton) {
        
        print("onSignUpTapped()")
        let newUser = PFUser()
        
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("Yay created a user.")
            }else if let error = error {
               print("[ERROR] \(error)")
            }
        }
        
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

