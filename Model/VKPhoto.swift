//
//  Photo.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit

class VKPhoto{
    
    struct Photo {
        var isLikeSet = false
        var likeCount = 0

        let albumID, date, id, ownerID: Int
        let hasTags: Bool
        //let sizes: [Size]
        let text: String
        //let likes: Likes
        //let reposts: Reposts
        let realOffset: Int
        
        
        init(item: Item) {
            self.albumID = item.albumID ?? -1
            self.date = item.date ?? 0
            self.id = item.id ?? -1
            self.ownerID = item.ownerID ?? -1
            self.hasTags = item.hasTags ?? false
            //self.sizes = Size(item.sizes?.count ?? 0) e()]
            self.text = item.text ?? ""
            //self.likes = item.likes ?? ""
            //self.reposts = item.reposts ?? Reposts()
            self.realOffset = item.realOffset ?? -1
        }
        
        enum ImageType{
            case imageSmall
            case imageMedium
            case imageBig
        }
        
        func getImage(imageType: ImageType) -> UIImage?{
            switch imageType {
            case .imageMedium:
                return nil
            default:
                return nil
            }
        }
        
        struct Reposts {
            let count: Int = 0
        }

        struct Size {
            let height: Int = 0
            let url: String = ""
            let type: String = ""
            let width: Int = 0
        }
    }

    struct PhotoRAW: Codable {
        let response: Response
    }

    // MARK: - Response
    struct Response: Codable {
        let count: Int?
        let items: [Item]?
        let more: Int?
    }

    // MARK: - Item
    struct Item: Codable {
        let albumID, date, id, ownerID: Int?
        let hasTags: Bool?
        let sizes: [Size]?
        let text: String?
        let likes: Likes?
        let reposts: Reposts?
        let realOffset: Int?

        enum CodingKeys: String, CodingKey {
            case albumID
            case date, id
            case ownerID
            case hasTags
            case sizes, text, likes, reposts
            case realOffset
        }
    }

    // MARK: - Likes
    struct Likes: Codable {
        let userLikes, count: Int?

        enum CodingKeys: String, CodingKey {
            case userLikes
            case count
        }
    }

    // MARK: - Reposts
    struct Reposts: Codable {
        let count: Int?
    }

    // MARK: - Size
    struct Size: Codable {
        let height: Int?
        let url: String?
        let type: String?
        let width: Int?
    }
}
