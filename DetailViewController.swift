//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    
    
    var tweet: Tweet!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = tweet.text
        usernameLabel.text =  tweet.user.name
        screennameLabel.text = tweet.user.screenName
        dateLabel.text = tweet.createdAtString
        
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
        
        profileImageView.af_setImage(withURL: URL(string: tweet.user.imageURL)!)
        
        if tweet.favorited! {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
        }
        if tweet.retweeted{
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetCountLabel.text = String(tweet.retweetCount)
            
            (sender as! UIButton).setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            
            APIManager.shared.reTweet(tweet){ (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }else{
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetCountLabel.text = String(tweet.retweetCount)
            
            (sender as! UIButton).setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
            
            APIManager.shared.unReTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func didTapFav(_ sender: Any) {
        if tweet.favorited! == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            favoriteCountLabel.text = String(tweet.favoriteCount)
            
            (sender as! UIButton).setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            
            APIManager.shared.favTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            favoriteCountLabel.text = String(tweet.favoriteCount)
            
            
            (sender as! UIButton).setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            
            APIManager.shared.unFavTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            print("About to reply")
            
            let replyViewController = segue.destination as! ReplyViewController
            replyViewController.tweet = tweet
        }
    }
    
}

