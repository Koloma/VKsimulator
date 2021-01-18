//
//  Array+ext.swift
//  VKsimulator
//
//  Created by Admin on 07.01.2021.
//

import Foundation

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
