//
//  NetworkAPI.swift
//  InstaProject
//
//  Created by my mac on 12/6/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import Foundation
import Parse




class NetworkAPI: NSObject{
    
    
   static let sharedInstance: NetworkAPI = NetworkAPI()
    
    
    let imageDataExtractErrorCode = 767
    let castingError  =  456
    
    func loadImage(file: PFFile?, successBlock: @escaping(UIImage) -> (Void), errorHandler: @escaping(NSError) -> (Void)){
        file?.getDataInBackground(block: { (data: Data?, error: Error?) in
            if let error = error {
               print("[ERROR] \(error)")
            }else{
                
                //Perform image processing on separate thread.
                let queue = OperationQueue()
                
                
                if let imageData = data {
                    queue.addOperation {
                        if let picture = UIImage(data: imageData) {
                            OperationQueue.main.addOperation {
                                successBlock(picture)
                            }
                        }else {
                            OperationQueue.main.addOperation {
                                errorHandler(NSError(domain: "Could not extract the data from image data.", code: self.imageDataExtractErrorCode, userInfo: nil))
                            }
                        }
                        
                        
                        
                    }
                }
            }
        })
        
    
    }
    
    
    func getHomeFeed(success: @escaping(([Post]) -> ()), failure: @escaping ((Error) -> ())){
        
        let query = PFQuery(className: Post.parseClassName())
        
        //Constraints
        query.limit = 20
        query.order(byDescending: "_created_at")
        
        self.loadPosts(query: query, onSuccess: { (posts: [Post]) -> (Void) in
        success(posts)
        }) {
            (error: Error) in
        failure(error)
        }
    
    }
    
    
    func loadPosts(query: PFQuery<PFObject>, onSuccess: @escaping([Post]) -> (Void), onFailure: @escaping(Error) -> ()){
        
        query.findObjectsInBackground { (pfPostObjects: [PFObject]?, error: Error?) in
            if let error = error {
               print("Something went wrong!")
                onFailure(error)
            }else if let posts = pfPostObjects as? [Post] {
                  print("Successfully extracted the posts")
                //Load the image for each post loaded
                for post in posts {
                    self.loadImage(file: post.media, successBlock: { (image: UIImage) -> (Void) in
                        post.image = image
                        //Create a notfiication each time an image is loaded.
                        onSuccess(posts)
                    }, errorHandler: { (error: NSError) -> (Void) in
                        print("[ERROR] Could not load the image for the post")
                    })
                }
                  onSuccess(posts)
            }else {
                print("Could not cast the post objects correctly")
                onFailure(NSError(domain: "Could not cast the post objects correctly ", code: self.castingError, userInfo: nil))
            }
        }
    
    }
    
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile?{
        guard let image = image else {
            print("No image passed in.")
            return nil
        }
        
        guard let imageData = UIImagePNGRepresentation(image) else {
            print("Could not extract the image data using PNG format.")
            return nil
        }
        
        return PFFile(name: "image.png", data: imageData)
        
        
    }

}
