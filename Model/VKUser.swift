//
//  VKFriend.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit

protocol userMustHave {
    
}

class VKUser{
    
    struct User {
        let id: Int
        let domain: String
        let firstName: String
        let lastName: String
        let sex: Int
        let photo50, photo100: String
        let online: Int
        let nickname: String
        let country: Country
        let photo200_Orig: String
        let status: String
        let lastSeen: LastSeen
        let birthdayDate: String
        let city: City
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
            self.country = Country(id: item.country?.id ?? -1, title: item.country?.title ?? "")
            self.photo200_Orig = item.photo200_Orig ?? ""
            self.status = item.status ?? ""
            self.lastSeen = LastSeen(platform: item.lastSeen?.platform ?? -1,time: item.lastSeen?.time ?? 0 )
            self.birthdayDate = item.birthdayDate ?? ""
            self.city = City(id: item.city?.id ?? -1, title: item.city?.title ?? "")
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
                url = URL(string: photo200_Orig)
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
