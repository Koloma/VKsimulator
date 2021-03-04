//
//  VKFriend.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit
import RealmSwift

   
//    struct User: ConvertToRealm {
//        let id: Int
//        let domain: String
//        let firstName: String
//        let lastName: String
//        let sex: Int
//        let photo50: String
//        let photo100: String
//        let photo200: String
//        let online: Int
//        let nickname: String
//        let country: String
//        let status: String
//        let lastSeen: Date
//        let birthdayDate: String
//        let city: String
//        let followersCount: Int
//        var fio: String{
//            get{
//                return self.firstName + " " + self.lastName
//            }
//        }
//
//        init(item: User) {
//            self.id = item.id ?? 0
//            self.domain = item.domain ?? ""
//            self.firstName = item.firstName ?? ""
//            self.lastName = item.lastName  ?? ""
//            self.sex = item.sex ?? -1
//            self.photo50 = item.photo50 ?? ""
//            self.photo100 = item.photo100 ?? ""
//            self.online = item.online ?? -1
//            self.nickname = item.nickname ?? ""
//            self.country = item.country?.title ?? ""
//            self.photo200 = item.photo200_Orig ?? ""
//            self.status = item.status ?? ""
//            if let date = item.lastSeen?.time{
//                self.lastSeen = Date.init(timeIntervalSince1970: date)
//            }
//            else{
//                self.lastSeen = Date.init(timeIntervalSince1970: 0)
//            }
//            self.birthdayDate = item.birthdayDate ?? ""
//            self.city = item.city?.title ?? ""
//            self.followersCount = item.followersCount ?? 0
//        }
//
//        internal init(id: Int, domain: String, firstName: String, lastName: String, sex: Int, photo50: String, photo100: String, photo200: String, online: Int, nickname: String, country: String, status: String, lastSeen: Double, birthdayDate: String, city: String, followersCount: Int) {
//            self.id = id
//            self.domain = domain
//            self.firstName = firstName
//            self.lastName = lastName
//            self.sex = sex
//            self.photo50 = photo50
//            self.photo100 = photo100
//            self.photo200 = photo200
//            self.online = online
//            self.nickname = nickname
//            self.country = country
//            self.status = status
//            self.lastSeen = Date.init(timeIntervalSince1970: lastSeen)
//            self.birthdayDate = birthdayDate
//            self.city = city
//            self.followersCount = followersCount
//        }
//
//        enum ImageType{
//            case image50
//            case image100
//            case image200
//        }
//
//        func getImage(imageType: ImageType, completion: @escaping (UIImage) -> ()){
//            var url:URL?
//            switch imageType {
//            case .image50:
//                url = URL(string: photo50)
//            case .image100:
//                url = URL(string: photo100)
//            case .image200:
//                url = URL(string: photo200)
//            }
//            if let url = url {
//                ImageCache.shared.load(url: url as NSURL){ image in
//                    completion(image)
//                }
//            }else{
//                completion(ImageCache.placeholderImage)
//            }
//        }
//    }
    
// MARK: - Welcome
struct UserRAW: Codable {
    let response: ResponseUser
}

// MARK: - Response
struct ResponseUser: Codable {
    let count: Int?
    let items: [VKUser]?
}

// MARK: - VKUser
class VKUser: Object, Codable {
    @objc dynamic var id: Int = 0
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
    
    override class func indexedProperties() -> [String] {
        ["id"]
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

    func getImage(imageType: ImageType, completion: @escaping (UIImage) -> ()){
        var url:URL?
        switch imageType {
        case .image50:
            url = URL(string: photo50 ?? "")
        case .image100:
            url = URL(string: photo100 ?? "")
        case .image200:
            url = URL(string: photo200 ?? "")
        }
        if let url = url {
            ImageCache.shared.load(url: url as NSURL){ image in
                completion(image)
            }
        }else{
            completion(ImageCache.placeholderImage)
        }
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


//
//extension VKUser.User{
//    func convertToRealm() -> RealmUser{
//        return RealmUser(id: self.id, domain: self.domain, firstName: self.firstName, lastName: self.lastName, sex: self.sex, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200, online: self.online, nickname: self.nickname, country: self.country, status: self.status, lastSeen: Double(self.lastSeen.timeIntervalSince1970), birthdayDate: self.birthdayDate, city: self.city, followersCount: self.followersCount )
//    }
//
//    func convertToRealm() -> Object {
//        return RealmUser(id: self.id, domain: self.domain, firstName: self.firstName, lastName: self.lastName, sex: self.sex, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200, online: self.online, nickname: self.nickname, country: self.country, status: self.status, lastSeen: Double(self.lastSeen.timeIntervalSince1970), birthdayDate: self.birthdayDate, city: self.city, followersCount: self.followersCount)
//    }
//}
