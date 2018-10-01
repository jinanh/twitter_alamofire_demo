//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Jinan Huang on 9/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User{
    var name: String
    var screenName: String
    var id: Int64
    var profileURLPath: URL
    
    init(dictionary: [String: Any]) {
        name = (dictionary["name"] as? String)!
        screenName = (dictionary["screen_name"] as? String)!
        id = dictionary["id"] as! Int64
        profileURLPath = URL(string: dictionary["profile_image_url_https"] as! String)!
    }
    
    static var current: User?{
        get{
            return nil
        }
        set(user){
            
        }
    }
}
