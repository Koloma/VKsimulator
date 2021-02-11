//
//  UserImages.swift
//  VKsimulator
//
//  Created by Admin on 11.02.2021.
//

import UIKit

// MARK: - UserImages
struct UserImagesData: Codable {
    let response: Response?


// MARK: - Response
struct Response: Codable {
    let count: Int?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let sizes: [Size]?
    let text: String?
    let postID: Int?
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case albumID
        case date, id
        case ownerID
        case hasTags
        case sizes, text
        case postID
        case lat, long
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let type: TypeEnum?
    let width: Int?
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

}
