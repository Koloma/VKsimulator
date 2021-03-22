//
//  K.swift
//  VKsimulator
//
//  Created by Admin on 22.01.2021.
//

import UIKit

struct K {
    struct Gradient {
        static let colorTop = UIColor(red: 1, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        static let colorBottom = UIColor(red: 1, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        
        static let colorTopAlpha = UIColor(red: 1, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.5).cgColor
        static let colorBottomAlpha = UIColor(red: 1, green: 149.0/255.0, blue: 0.0/255.0, alpha: 0.5).cgColor
    }
    
    struct Colors{
        static let refresher = UIColor.blue
    }
    
    struct ApiVK {
        static let v = "5.130"
        static let baseUrl = "https://api.vk.com"
        static let pathGetGroups = "/method/groups.get"
        static let pathGroupsSearch = "/method/groups.search"
        static let pathGetFriends = "/method/friends.get"
        static let pathGetUserAllPhotos = "/method/photos.getAll"
        static let pathGetUserNewsfeed = "/method/newsfeed.get"
    }

}
