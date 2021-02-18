//
//  Protocols.swift
//  VKsimulator
//
//  Created by Admin on 18.02.2021.
//

import Foundation
import RealmSwift

protocol ConvertToClear {
    func convertToClear() -> Any
}

protocol ConvertToRealm {
    func convertToRealm() -> Object
}
