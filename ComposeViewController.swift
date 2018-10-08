//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var charaterCountLabel: UILabel!
    
    
    weak var delegate: ComposeViewControllerDelegate?
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self
        tweetText.isEditable = true
        
        profileImageView.af_setImage(withURL: URL(string: (User.current?.imageURL)!)!)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetText.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        // dismiss(animated: true, completion: nil)
    }
  
    
    @IBAction func didCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }




func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    // TODO: Check the proposed new text character count
    // Allow or disallow the new text
    
    // Set the max character limit
    let characterLimit = 140
    
    // Construct what the new text would be if we allowed the user's latest edit
    let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
    
    // TODO: Update Character Count Label
    charaterCountLabel.text = String(characterLimit - newText.characters.count)
    
    
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

