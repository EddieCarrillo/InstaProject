//
//  CaptureViewController.swift
//  InstaProject
//
//  Created by my mac on 12/6/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    
    @IBOutlet weak var captionTextField: UITextField!
    
    
  //  var finishedSubmitting: (()->()) = {}
    
    
    
    
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
        
        Post.postUserImage(image: image, withCaption: self.captionTextField.text!) { (success: Bool, error: Error?) in
            if let error = error {
                print("[ERROR] \(error)")
            }else if success {
                print("Image uploaded successfully")
            }
        }
        
        //Reset to the first view controller
        self.tabBarController?.selectedIndex = 0
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageChooserTapped))
        
        self.captureImageView.isUserInteractionEnabled = true
        
        
        self.captureImageView.gestureRecognizers = []
        self.captureImageView.gestureRecognizers?.append(tapGesture)
        //self.captureImageView.addGestureRecognizer(tapGesture)
        
        print(self.captureImageView.frame.size.height)
        

        // Do any additional setup after loading the view.
    }
    
    func imageChooserTapped(){
        print("imagechoosertapped")
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = true
        //Choose from library
        imagePickerViewController.sourceType  = UIImagePickerControllerSourceType.photoLibrary
        
        
        self.present(imagePickerViewController, animated: true) {
            print("Image picker view controller is being displayed!")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.captureImageView.image = originalImage
        dismiss(animated: true, completion: nil)
    }
    
    

}
