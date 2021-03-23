//
//  ResponseError.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 23.03.2021.
//

import Foundation

struct VKErrorRAW: Codable {
    let error: VKError
}

// MARK: - Error
struct VKError: Codable {
    let errorCode: Int
    let errorMsg: String
    let requestParams: [RequestParam]

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
        case requestParams = "request_params"
    }
}

// MARK: - RequestParam
struct RequestParam: Codable {
    let key, value: String
}
