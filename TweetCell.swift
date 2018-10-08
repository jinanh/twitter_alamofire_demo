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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorHandLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replayLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    
    
    @IBOutlet weak var FavButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    @IBOutlet weak var replyButton: UILabel!
    

   
    var retweetOn: Bool = false
    var favOn: Bool = false
    
    var tweet: Tweet! {
        didSet{
            profileImageView.af_setImage(withURL: URL(string: tweet.user.imageURL)!)
            authorLabel.text = tweet.user.name
            authorHandLabel.text = "@\(tweet.user.screenName)"
            dateLabel.text = tweet.createdAtString
            tweetTextLabel.text = tweet.text
            retweetLabel.text = String(tweet.retweetCount)
            favLabel.text = String(tweet.favoriteCount)
            if tweet.favorited!{
                favOn = true
                FavButton.imageView?.image = #imageLiteral(resourceName: "favor-icon-red")
            }else{
                favOn = false
            }
            if tweet.retweeted{
                retweetOn = true
                reTweetButton.imageView?.image = #imageLiteral(resourceName: "retweet-icon-green")
            }else{
                retweetOn = false
            }
        }
    }
    
    @IBAction func didTapFav(_ sender: Any) {
        if favOn{
            favOn = false
            tweet.favorited = false
            tweet.favoriteCount -= 1
            APIManager.shared.unFavTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
        } else  {
            favOn = true
            tweet.favorited = true
            tweet.favoriteCount += 1
            APIManager.shared.favTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
        }
        
    }
    
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if retweetOn {
            retweetOn = false
            tweet.retweeted = false
            tweet.retweetCount -= 1
            APIManager.shared.unReTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
        } else {
            retweetOn = true
            tweet.retweeted = true
            tweet.retweetCount += 1
            APIManager.shared.reTweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
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
