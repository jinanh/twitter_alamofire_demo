//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 9/30/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    // TODO: Add properties
    
    // TODO: Create initializer
    
    // MARK: Properties
    var name: String
    var screenName: String
    var imageURL: String
    
    //...
    var banner_url: URL
    var followers: Int?
    var following: Int?
    var location: String
    var tweets: Int?
    var description: String
    var dict: [String: Any]?
    // Add any additional properties here
    private static var _current: User?
    
    
    init(dictionary: [String: Any]) {
        self.dict = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        let image = dictionary["profile_image_url_https"]as! String
        imageURL = String((image.dropLast(11))) + ".jpg"
        //...
        // Initialize any other properties
        
        if !(dictionary["profile_banner_url"] == nil){
            banner_url = URL(string: dictionary["profile_banner_url"] as! String)!
        }else{
            banner_url = URL(string: "nil")!
        }
        followers = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        location = dictionary["location"] as! String
        tweets = dictionary["statuses_count"] as? Int
        description = dictionary["description"] as! String
        
    }
    
    //private static var _current: User?
    
    static var current: User? {
        get{
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userDate = defaults.data(forKey: "currentUserData"){
                    let dict = try! JSONSerialization.jsonObject(with: userDate, options: []) as! [String: Any]
                    _current = User(dictionary: dict)
                }
            }
            return _current
        }
        
        set(user){
            _current = current
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dict!, options: [])
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.removeObject(forKey: "currentUserData")
            }
        }
        
    }
    
    
}
