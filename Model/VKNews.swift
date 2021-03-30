//
//  VKNews.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 22.03.2021.
//

import UIKit

struct VKNewsRAW: Codable {
    let response: ResponseNews
}

// MARK: - Response
struct ResponseNews: Codable {
    let items: [VKNews]?
    let profiles: [VKProfile]?
    let groups: [VKGroup]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Item
struct VKNews: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory: Bool?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let postSource: PostSource?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let isFavorite: Bool?
    let shortTextRate: Double?
    let carouselOffset: Int?
    let postID: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case carouselOffset = "carousel_offset"
        case postID = "post_id"
        case type
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let photo: VKPhoto?
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}
