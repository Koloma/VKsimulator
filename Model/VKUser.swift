//
//  VKFriend.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit
import RealmSwift

class VKUser{
    
    struct User: ConvertToRealm {
        let id: Int
        let domain: String
        let firstName: String
        let lastName: String
        let sex: Int
        let photo50: String
        let photo100: String
        let photo200: String
        let online: Int
        let nickname: String
        let country: String
        let status: String
        let lastSeen: Int
        let birthdayDate: String
        let city: String
        var fio: String{
            get{
                return self.firstName + " " + self.lastName
            }
        }
        
        init(item: Item) {
            self.id = item.id ?? 0
            self.domain = item.domain ?? ""
            self.firstName = item.firstName ?? ""
            self.lastName = item.lastName  ?? ""
            self.sex = item.sex ?? -1
            self.photo50 = item.photo50 ?? ""
            self.photo100 = item.photo100 ?? ""
            self.online = item.online ?? -1
            self.nickname = item.nickname ?? ""
            self.country = item.country?.title ?? ""
            self.photo200 = item.photo200_Orig ?? ""
            self.status = item.status ?? ""
            self.lastSeen = item.lastSeen?.time ?? 0
            self.birthdayDate = item.birthdayDate ?? ""
            self.city = item.city?.title ?? ""
        }
        
        internal init(id: Int, domain: String, firstName: String, lastName: String, sex: Int, photo50: String, photo100: String, photo200: String, online: Int, nickname: String, country: String, status: String, lastSeen: Int, birthdayDate: String, city: String) {
            self.id = id
            self.domain = domain
            self.firstName = firstName
            self.lastName = lastName
            self.sex = sex
            self.photo50 = photo50
            self.photo100 = photo100
            self.photo200 = photo200
            self.online = online
            self.nickname = nickname
            self.country = country
            self.status = status
            self.lastSeen = lastSeen
            self.birthdayDate = birthdayDate
            self.city = city
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
                url = URL(string: photo50)
            case .image100:
                url = URL(string: photo100)
            case .image200:
                url = URL(string: photo200)
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
    
    // MARK: - Welcome
    struct UserRAW: Codable {
        let response: Response
    }

    // MARK: - Response
    struct Response: Codable {
        let count: Int?
        let items: [Item]?
    }

    // MARK: - Item
    struct Item: Codable {
        let id: Int?
        let domain: String?
        let firstName: String?
        let lastName: String?
        let sex: Int?
        let photo50, photo100: String?
        let online: Int?
        let nickname: String?
        let country: Country?
        let photo200_Orig: String?
        let status: String?
        let lastSeen: LastSeen?
        let birthdayDate: String?
        let city: City?

        enum CodingKeys: String, CodingKey {
            case id
            case domain
            case firstName = "first_name"
            case lastName = "last_name"
            case sex
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case online
            case nickname
            case country
            case photo200_Orig
            case status
            case lastSeen = "last_seen"
            case birthdayDate = "bdate"
            case city
        }
    }

    // MARK: - City
    struct City: Codable {
        let id: Int?
        let title: String?
    }
    
    // MARK: - Country
    struct Country: Codable {
        let id: Int?
        let title: String?
    }

    // MARK: - LastSeen
    struct LastSeen: Codable {
        let platform, time: Int?
    }
    
}

extension VKUser.User{
    func convertToRealm() -> RealmUser{
        return RealmUser(id: self.id, domain: self.domain, firstName: self.firstName, lastName: self.lastName, sex: self.sex, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200, online: self.online, nickname: self.nickname, country: self.country, status: self.status, lastSeen: self.lastSeen, birthdayDate: self.birthdayDate, city: self.city)
    }
    
    func convertToRealm() -> Object {
        return RealmUser(id: self.id, domain: self.domain, firstName: self.firstName, lastName: self.lastName, sex: self.sex, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200, online: self.online, nickname: self.nickname, country: self.country, status: self.status, lastSeen: self.lastSeen, birthdayDate: self.birthdayDate, city: self.city)
    }
}
