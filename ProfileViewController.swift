//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followsCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerImageView.af_setImage(withURL: (User.current?.banner_url)!)
        profileImageView.af_setImage(withURL: URL(string: (User.current?.imageURL)!)!)
        usernameLabel.text = User.current?.name
        screennameLabel.text = User.current?.screenName
        descriptionLabel.text = User.current?.description
        followsCountLabel.text = String(describing: User.current!.followers!)
        followingCountLabel.text = String(describing: User.current!.following!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
