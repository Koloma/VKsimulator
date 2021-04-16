//
//  VKGroup.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import UIKit
import RealmSwift



// MARK: - GroupRAW
struct GroupRAW: Codable {
    let response: ResponseGroup
}

// MARK: - ResponseGroup
struct ResponseGroup: Codable {
    let count: Int?
    let items: [VKGroup]?
}


// MARK: - Group
class VKGroup: Object, Codable, Comparable {

    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName  = "screen_name"
        case isClosed = "is_closed"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
 
   
    override class func primaryKey() -> String? {
        "id"
    }
    
    static func == (lhs: VKGroup, rhs: VKGroup) -> Bool {
        let areEqual = lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.screenName == rhs.screenName

        return areEqual
    }
    
    static func < (lhs: VKGroup, rhs: VKGroup) -> Bool {
        return lhs.name < rhs.name
    }
 
    enum ImageType{
        case image50
        case image100
        case image200
    }
    
    func getImage(imageType: ImageType, completion: @escaping (UIImage?) -> ())-> UIImage?{
        var url:String
        switch imageType {
        case .image50:
            url = photo50
        case .image100:
            url = photo100
        case .image200:
            url = photo200
        }
        let image = CacheService.shared.photo(byUrl: url){ image in
            completion(image)
        }
        return image
    }
    
}


