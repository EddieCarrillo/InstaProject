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
    @NSManaged var caption: String?
    
    var image: UIImage?
    
    
    
    
    
    
    

}
