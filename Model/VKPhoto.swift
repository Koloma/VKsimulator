//
//  Photo.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit

class VKPhoto{
    
    struct Photo {
        var isLikeSet: Bool
        var likesCount: Int = 0
        let albumID, date, id, ownerID: Int
        let text: String
        let repostsCount: Int
        let realOffset: Int
        var imageUrlS75px: String = ""
        var imageUrlM130px: String = ""
        var imageUrlX604px: String = ""
        var imageUrlZ1080: String = ""
        var imageUrlW2560: String = ""
        
        internal init(isLikeSet: Bool, likesCount: Int, albumID: Int, date: Int, id: Int, ownerID: Int, text: String, repostsCount: Int, realOffset: Int, imageUrlS75px: String, imageUrlM130px: String, imageUrlX604px: String, imageUrlZ1080: String, imageUrlW2560: String) {
            self.isLikeSet = isLikeSet
            self.likesCount = likesCount
            self.albumID = albumID
            self.date = date
            self.id = id
            self.ownerID = ownerID
            self.text = text
            self.repostsCount = repostsCount
            self.realOffset = realOffset
            self.imageUrlS75px = imageUrlS75px
            self.imageUrlM130px = imageUrlM130px
            self.imageUrlX604px = imageUrlX604px
            self.imageUrlZ1080 = imageUrlZ1080
            self.imageUrlW2560 = imageUrlW2560
        }
        
        init(item: Item) {
            if let like = item.likes?.userLikes{
                self.isLikeSet = like == 1
            }else{
                self.isLikeSet = false
            }
            
            self.albumID = item.albumID ?? -1
            self.date = item.date ?? 0
            self.id = item.id ?? -1
            self.ownerID = item.ownerID ?? -1
            self.text = item.text ?? ""
            self.repostsCount = item.reposts?.count ?? 0
            self.realOffset = item.realOffset ?? -1
            self.likesCount = item.likes?.count ?? 0
            
            if let sizes  = item.sizes{
                for size in sizes{
                    if let type = size.type{
                        switch type {
                        case ImageType.s75px.rawValue:
                            self.imageUrlS75px = size.url ?? ""
                        case ImageType.m130px.rawValue:
                            self.imageUrlM130px = size.url ?? ""
                        case ImageType.x604px.rawValue:
                            self.imageUrlX604px = size.url ?? ""
                        case ImageType.z1080.rawValue:
                            self.imageUrlZ1080 = size.url ?? ""
                        case ImageType.w2560.rawValue:
                            self.imageUrlW2560 = size.url ?? ""
                        default:
                            print("")
                        }
                    }
                }
            }
        }
        
        enum ImageType: String{
            case s75px = "s"
            case m130px = "m"
            case x604px = "x"
            case z1080 = "z"
            case w2560 = "w"
        }
               
        func getImage(imageType: ImageType, completion: @escaping (UIImage) -> ()){
            var url:URL?
            switch imageType {
            case .s75px:
                url = URL(string: self.imageUrlS75px)
            case .m130px:
                url = URL(string: self.imageUrlM130px)
            case .x604px:
                url = URL(string: self.imageUrlX604px)
            case .z1080:
                url = URL(string: self.imageUrlZ1080)
            case .w2560:
                url = URL(string: self.imageUrlW2560)
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

extension VKPhoto.Photo{
    func convertToRealm() -> RealmPhoto{
        return RealmPhoto(isLikeSet: self.isLikeSet, likesCount: self.likesCount, albumID: self.albumID, date: self.date, id: self.id, ownerID: self.ownerID, text: self.text, repostsCount: self.repostsCount, realOffset: self.realOffset, imageUrlS75px: self.imageUrlS75px, imageUrlM130px: self.imageUrlM130px, imageUrlX604px: self.imageUrlX604px, imageUrlZ1080: self.imageUrlZ1080, imageUrlW2560: self.imageUrlW2560)
    }
}
