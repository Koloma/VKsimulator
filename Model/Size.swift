//
//  Size.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 22.03.2021.
//

import Foundation
import RealmSwift

// MARK: - Size
class Size: Object, Codable {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
}
