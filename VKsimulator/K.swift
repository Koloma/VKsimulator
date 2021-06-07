//
//  K.swift
//  VKsimulator
//
//  Created by Admin on 22.01.2021.
//

import UIKit

struct K {
    struct Gradient {
        static let colorTop = UIColor.rgba(1.0, 94.0, 58.0, a: 1.0).cgColor
        static let colorBottom = UIColor.rgba(1.0, 149.0, 0, a: 1.0).cgColor
        
        static let colorTopAlpha = UIColor.rgba(1.0, 94.0, 58.0, a: 1.0).cgColor
        static let colorBottomAlpha = UIColor.rgba(1.0, 149.0, 0, a: 1.0).cgColor
    }
    
    struct Colors{
        static let refresher = UIColor.blue
    }
    
    struct ApiVK {
        static let v = "5.130"
        static let baseUrl = "https://api.vk.com"
        static let pathGetGroups = "/method/groups.get"
        static let pathGetGroupsById = "/method/groups.getById"
        static let pathGroupsSearch = "/method/groups.search"
        static let pathGetFriends = "/method/friends.get"
        static let pathGetUsers = "/method/users.get"
        static let pathGetUserAllPhotos = "/method/photos.getAll"
        static let pathGetUserNewsfeed = "/method/newsfeed.get"
    }

}
