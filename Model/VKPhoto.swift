//
//  Photo.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit
import RealmSwift

    struct PhotoRAW: Codable {
        let response: ResponsePhoto
    }

    // MARK: - Response
    struct ResponsePhoto: Codable {
        let count: Int?
        let items: [VKPhoto]?
        let more: Int?
    }

    // MARK: - Item
    class VKPhoto: Object, Codable {
        @objc dynamic var id = -1
        @objc dynamic var albumID = -1
        @objc dynamic var date = 0
        @objc dynamic var ownerID = -1
        @objc dynamic var text: String = ""
        //@objc dynamic var realOffset: Int = 0
        @objc dynamic var likes: Likes?
        @objc dynamic var reposts: Reposts?
        let sizes:[Size]

        override class func primaryKey() -> String? {
            "id"
        }
        
        enum CodingKeys: String, CodingKey {
            case albumID = "album_id"
            case date, id
            case ownerID = "owner_id"
            case sizes, text, likes, reposts
           // case realOffset = "real_offset"
        }
        
        enum ImageType: String{
            case s = "s"
            case m = "m"
            case x = "x"
            case z = "z"
            case y = "y"
        }
        
        func getUrl(imageType: ImageType) -> String{
            if let index = sizes.firstIndex(where: {$0.type == imageType.rawValue}){
                return sizes[index].url
            } else{
                return sizes[0].url
            }
        }

        func getSize(imageType: ImageType) -> CGSize{
            if let index = sizes.firstIndex(where: {$0.type == imageType.rawValue}){
                return CGSize(width: sizes[index].width, height: sizes[index].height)
            } else{
                return CGSize(width: 50, height: 50)
            }
        }
        
        func getImage(imageType: ImageType, completion: @escaping (UIImage?) -> ()) -> UIImage? {
            
            if let index = sizes.firstIndex(where: {$0.type == imageType.rawValue}) {
                if let url = URL(string: sizes[index].url){
                    let imageCache = CacheService.shared.photo(byUrl: url.absoluteString){ image in
                        completion(image)        
                    }
                    return imageCache
                }
            }
                
            return nil
        }
        
    }
