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
    
    
    
    var refreshControl: UIRefreshControl!
    
    
    var posts: [Post] = []
    
    let feedCellId = "FeedCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        self.refreshControl = UIRefreshControl()

        self.tableview.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(startRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    }
    
    func startRefresh(refreshControl: UIRefreshControl){
        refreshControl.beginRefreshing()
        self.refreshData()
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
            self.refreshControl.endRefreshing()
        }) { (error: Error) in
            print("Error \(error)")
            self.refreshControl.endRefreshing()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellId, for: indexPath) as! CellFeedTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! CellFeedTableViewCell
        
        guard  let indexPath = tableview.indexPath(for: cell) else {
            print("Could not retrieve the indexpath")
            return
        }
        
        
        
        let post = posts[indexPath.row]
        
        let detailViewController = segue.destination as! FeedDetailViewController
        
        detailViewController.post = post
        
        
    }

}
