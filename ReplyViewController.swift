//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var replyText: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    
    var tweet: Tweet!
    //var replyTweet: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyText.delegate = self
        replyText.isEditable = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapReply(_ sender: Any) {
        var replyTweet: [String: Any] = [:]
        replyTweet["text"] = self.replyText.text! + "@" + tweet.user.screenName
        replyTweet["id"] = tweet.id
        print(tweet.id)
        
        APIManager.shared.reply(with: replyTweet){(tweet, error) in
            if let error = error{
                print("Error composing Tweet: \(error.localizedDescription)")
            }else if let tweet = tweet {
                print("Reply Tweet Successfully!")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        
        // Set the max character limit
        
        let characterLimit = 140
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        // TODO: Update Character Count Label
        characterCountLabel.text = String(characterLimit - newText.characters.count)
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

