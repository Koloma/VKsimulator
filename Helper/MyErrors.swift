//
//  MyErrors.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 08.04.2021.
//

import Foundation

enum MyErrors: Error{
    case noData
    case loginError
    case userCouldNotBeParsed
    case newsfeed(msg: String)
}
