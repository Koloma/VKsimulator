//
//  Response.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 29.03.2021.
//

import Foundation

struct ResponseRAW: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int?
    let items: [VKPhoto]?
    let more: Int?
}
