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
        
        var likesCount = 0
        let albumID, date, id, ownerID: Int
        var sizes: [Size]
        let text: String
        let repostsCount: Int
        let realOffset: Int
        
        
        init(item: Item) {
            self.albumID = item.albumID ?? -1
            self.date = item.date ?? 0
            self.id = item.id ?? -1
            self.ownerID = item.ownerID ?? -1
            self.text = item.text ?? ""
            self.repostsCount = item.reposts?.count ?? 0
            self.realOffset = item.realOffset ?? -1
            self.likesCount = item.likes?.count ?? 0
            
            self.sizes = []
            if let sizes  = item.sizes{
                var mySizes : [Size] = []
                for size in sizes{
                    mySizes.append(Size(height: size.height ?? 0,
                                           url: size.url ?? "",
                                           type: size.type ?? "",
                                           width: size.width ?? 0)
                    )
                    self.sizes = mySizes
                }
            }
            
        }
        
        enum ImageType{
            case s75px
            case m130px
            case x604px
            case z1080
            case w2560
        }
               
        func getImage(imageType: ImageType, completion: @escaping (UIImage) -> ()){
            var url:URL?
            switch imageType {
            case .s75px:
                if let index = sizes.firstIndex(where: { $0.type == "s" }){
                    url = URL(string: sizes[index].url)
                }
            case .m130px:
                if let index = sizes.firstIndex(where: { $0.type == "m" }){
                    url = URL(string: sizes[index].url)
                }
            case .x604px:
                if let index = sizes.firstIndex(where: { $0.type == "x" }){
                    url = URL(string: sizes[index].url)
                }
            case .z1080:
                if let index = sizes.firstIndex(where: { $0.type == "z" }){
                    url = URL(string: sizes[index].url)
                }
            case .w2560:
                if let index = sizes.firstIndex(where: { $0.type == "w" }){
                    url = URL(string: sizes[index].url)
                }
            }
            
            if let url = url {
                ImageCache.shared.load(url: url as NSURL){ image in
                    completion(image)
                }
            }else{
                completion(ImageCache.placeholderImage)
            }
        }
        
        struct Reposts {
            let count: Int
        }

        struct Size {
            let height: Int
            let url: String
            let type: String
            let width: Int
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
        let sizes: [Size]?
        let text: String?
        let likes: Likes?
        let reposts: Reposts?
        let realOffset: Int?

        enum CodingKeys: String, CodingKey {
            case albumID = "album_id"
            case date, id
            case ownerID = "owner_id"
            case sizes, text, likes, reposts
            case realOffset = "real_offset"
        }
    }

    // MARK: - Likes
    struct Likes: Codable {
        let userLikes, count: Int?

        enum CodingKeys: String, CodingKey {
            case userLikes = "user_likes"
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
