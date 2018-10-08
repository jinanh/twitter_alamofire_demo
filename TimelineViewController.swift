//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {
    func did(post: Tweet) {
        self.fetchTweet()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tweets: [Tweet] = []
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        // Do any additional setup after loading the view.
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        self.activityIndicator.startAnimating()
        
        APIManager.shared.getHomeTimeLine{ (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }else if let error = error {
                print("Error geeting home timeline: " + error.localizedDescription)
                self.myAlert(title: "Cannot Get Tweets", message: "The Internet connection appears to be offline.")
            }
            
        }
    }
    
    func myAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: "Cannot Get Tweets", message: "The Internet connection appears to be offline.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "TRY AGAIN", style: .default, handler: { (action) in
            // handle response here.
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        //fetchTweet()
        
        APIManager.shared.getNewHomeTimeLine{ (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }else if let error = error {
                print("Error geeting home timeline: " + error.localizedDescription)
                self.myAlert(title: "Cannot Get Tweets", message: "The Internet connection appears to be offline.")
            }
            
        }
        self.refreshControl.endRefreshing()
    }
    
    func fetchTweet() {
        APIManager.shared.getHomeTimeLine { (tweets, err) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            } else if let err = err {
                print(err.localizedDescription)
                self.myAlert(title: "Cannot Get Tweets", message: "The Internet connection appears to be offline.")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.tweet = tweet
            }
        }else if segue.identifier == "composeSegue"{
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.delegate = self
            
        }else if segue.identifier == "profileSegue" {
            print("profile view button")
        }
    }
    
    
}

