//
//  Reposts.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 22.03.2021.
//

import Foundation
import RealmSwift

class Reposts: Object, Codable {
    @objc dynamic var count: Int = 0
}
