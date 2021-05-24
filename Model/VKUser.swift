//
//  VKFriend.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit
import RealmSwift

// MARK: - Welcome
struct UserRAW: Codable {
    let response: ResponseUser
}

// MARK: - ResponseUser
struct ResponseUser: Codable {
    let count: Int?
    let items: [VKUser]?
}

// MARK: - VKUser
class VKUser: Object, Codable {
    @objc dynamic var id: Int = -1
    @objc dynamic var domain: String? = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var sex: Int = -1
    @objc dynamic var photo50: String? = ""
    @objc dynamic var photo100: String? = ""
    @objc dynamic var photo200: String? = ""
    @objc dynamic var online: Int = -1
    @objc dynamic var nickname: String? = ""
    @objc dynamic var country: Country?
    @objc dynamic var status: String? = ""
    @objc dynamic var lastSeen: LastSeen?
    @objc dynamic var birthdayDate: String? = ""
    @objc dynamic var city: City?
    //@objc dynamic var followersCount: Int = 0
    
    var fio:String {
        return "\(firstName) \(lastName)"
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case domain
        case firstName = "first_name"
        case lastName = "last_name"
        case sex
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200_orig"
        case online
        case nickname
        case country
        case status
        case lastSeen = "last_seen"
        case birthdayDate = "bdate"
        case city
        //case followersCount = "followers_count"
    }
    
    enum ImageType{
        case image50
        case image100
        case image200
    }

    func getImage(imageType: ImageType, completion: ((UIImage?) -> ())? = nil)-> UIImage?{
        var url:String
        switch imageType {
        case .image50:
            url = photo50 ?? ""
        case .image100:
            url = photo100 ?? ""
        case .image200:
            url = photo200 ?? ""
        }
        
        let image = CacheService.shared.photo(byUrl: url){ image in
            completion?(image)
        }
        return image
    }
}

// MARK: - City
class City: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
}

// MARK: - Country
class Country: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
}

// MARK: - LastSeen
class LastSeen: Object, Codable {
    @objc dynamic var platform: Int = -1
    @objc dynamic var time: Double = 0
}

