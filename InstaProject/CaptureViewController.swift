//
//  CaptureViewController.swift
//  InstaProject
//
//  Created by my mac on 12/6/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController {

    
    
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    
    @IBOutlet weak var captionTextField: UITextField!
    
    
    
    
    @IBAction func onSubmitTapped(_ sender: Any) {
        
        guard let image = self.captureImageView.image else {
            //User did not set the image so ...
           print("There was no image set ")
            
            let alertController = UIAlertController(title: "Missing Image", message: "Please Choose an Image", preferredStyle: UIAlertControllerStyle.alert)
            
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction) in
                print("OK PRESSED.")
                //Just dismiss the alert.
            })
            
            
            
            return
            
        
        }
        
      //Post the data to the server
        
        
    
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
