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
            case s75px = "s"
            case m130px = "m"
            case x604px = "x"
            case z1080 = "z"
            case w2560 = "w"
        }
               
        func getImage(imageType: ImageType, completion: @escaping (UIImage) -> ()){
            if let index = sizes.firstIndex(where: {$0.type == imageType.rawValue}) {
                if let url = URL(string: sizes[index].url){
                    ImageCache.shared.load(url: url as NSURL){ image in
                        completion(image)
                    }
                } else{
                    completion(ImageCache.placeholderImage)
                }
                
            }else{
                completion(ImageCache.placeholderImage)
            }
        }
    }
