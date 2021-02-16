//
//  VKGroup.swift
//  VKsimulator
//
//  Created by Admin on 15.02.2021.
//

import Foundation

class VKGroup{
    
    struct Group{
        let id: Int
        let name: String
        let screenName: String
        let isClosed: Int
        let photo50: String
        let photo100: String
        let photo200: String
        
        init(item : Item) {
            self.id = item.id ?? 0
            self.name = item.name ?? ""
            self.screenName = item.screenName ?? ""
            self.isClosed = item.isClosed ?? 0
            self.photo50 = item.photo50 ?? ""
            self.photo100 = item.photo100 ?? ""
            self.photo200 = item.photo200 ?? ""
        }
    }
    
    struct GroupRAW: Codable {
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
        let name: String?
        let screenName: String?
        let isClosed: Int?
        let type: String?
        let photo50: String?
        let photo100: String?
        let photo200: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case screenName  = "screen_name"
            case isClosed = "is_closed"
            case type
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case photo200 = "photo_200"
        }
    }

}
