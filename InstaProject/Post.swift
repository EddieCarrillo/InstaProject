//
//  Post.swift
//  InstaProject
//
//  Created by my mac on 12/6/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import Foundation
import Parse



class Post: PFObject, PFSubclassing {

    public static func parseClassName() -> String {
        return "Post"
    }
    

    @NSManaged var media: PFFile?
    @NSManaged var author: PFUser?

    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    var image: UIImage?
    
    
    /*Method to add a user post to Parse (uploading image file)
    
    - parameter image: Image that the user wants upload to parse
    - parameter caption: Caption text input by the user
    - parameter completion: Block to be executed after save operation is complete
    */
    
    class func postUserImage(image: UIImage?, withCaption caption: String, withCompletion completion: PFBooleanResultBlock?){
        //Using subclass approach.
        
         let api = NetworkAPI.sharedInstance
        
        let post = Post()
        post.media = NetworkAPI.getPFFileFromImage(image: image)
        post.author = PFUser.current()
        post.caption = caption
        post.likesCount = 0
        post.commentsCount = 0
        
        post.saveInBackground(block: completion)
    }
    
    
    

}
