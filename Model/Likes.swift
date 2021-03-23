//
//  Likes.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 22.03.2021.
//

import Foundation
import RealmSwift


class Likes: Object, Codable {
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var count: Int = 0

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}
