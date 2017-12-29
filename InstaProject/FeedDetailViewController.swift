//
//  FeedDetailViewController.swift
//  InstaProject
//
//  Created by Eduardo Carrillo on 12/28/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var captionTextLabel: UILabel!
    
    
    var post: Post!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let api = NetworkAPI.sharedInstance
        let photoFile = post.media
        
        api.loadImage(file: photoFile, successBlock: { (image: UIImage) -> (Void) in
            self.photoImageView.image = image
        }) { (error: NSError) -> (Void) in
            print("[ERROR] \(error)")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        dateFormatter.dateFormat = "MM/dd/YYYY hh:mm a EE"
        
        let dateString = dateFormatter.string(from: post.createdAt!)
        
        self.timestampLabel.text = dateString
        
        self.captionTextLabel.text = post.caption
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
