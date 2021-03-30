//
//  VKProfile.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 28.03.2021.
//

import UIKit

// MARK: - Profile
struct VKProfile: Codable {
    let firstName: String?
    let id: Int?
    let lastName: String?
    let canAccessClosed, isClosed: Bool?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let onlineInfo: OnlineInfo?
    let online: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
