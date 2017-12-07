//
//  CellFeedTableViewCell.swift
//  InstaProject
//
//  Created by my mac on 12/6/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit

class CellFeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post?{
    
        didSet{
            
            guard let post = self.post else {
               print("Something weird happened")
                return
            }
            
            //Probably in the proccess of loading the iamge
            posterImageView.image = post?.image
            
            captionLabel.text = post.caption
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

    
    
    
    
    
    

}
