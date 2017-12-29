//
//  FeedViewController.swift
//  InstaProject
//
//  Created by my mac on 12/6/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource {
   
    

    @IBOutlet weak var tableview: UITableView!
    
    
    var posts: [Post] = []
    
    let feedCellId = "FeedCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func refreshData(){
        let api = NetworkAPI.sharedInstance
        
        api.getHomeFeed(success: { (posts: [Post]) in
            self.posts = posts
            self.tableview.reloadData()
        }) { (error: Error) in
            print("Error \(error)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellId, for: indexPath) as! CellFeedTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }

}
