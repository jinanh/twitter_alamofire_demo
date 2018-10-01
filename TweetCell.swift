//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 9/30/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetMessage: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    
    
    var tweet: Tweet!{
        didSet{
            tweetMessage.text = tweet.text
            username.text = tweet.user?.name
            screenName.text = "@\(tweet.user!.screenName) \(tweet.createdAtString!)"
            if let cnt = tweet.favoriteCount{
                favoriteCount.text = String(cnt)
            }
            else{
                favoriteCount.text = String(0)
            }
            if let cnt = tweet.retweetCount{
                retweetCount.text = String(cnt)
            }
            else{
                retweetCount.text = String(0)
            }
            
            profileImageView.af_setImage(withURL: (tweet.user?.profileURLPath)!)
            
        }
    }
 
    
    
    
    
    @IBAction func tapLove(_ sender: Any) {
        if(!(tweet.favorited!)){
            let image = UIImage(named: "favor-icon-red")
            heartBtn.setImage(image, for: UIControlState.normal)
            tweet.favorited = true
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCount.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "favor-icon")
            heartBtn.setImage(image, for: UIControlState.normal)
            tweet.favorited = false
            APIManager.shared.unfavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unfavorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCount.text = String(count)
                }
            }
        }
    }
    
    
 
    
    
    
    @IBAction func tapRetweet(_ sender: Any) {
        if(!(tweet.retweeted!)){
            let image = UIImage(named: "retweet-icon-green")
            retweetBtn.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully retweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCount.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "retweet-icon")
            retweetBtn.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = false
            APIManager.shared.unretweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unretweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCount.text = String(count)
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
