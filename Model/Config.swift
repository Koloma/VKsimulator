//
//  Config.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 19.03.2021.
//

import Foundation

enum DataBaseType{
    case database, firestore
}

enum Config{
    static let dataBaseType = DataBaseType.database
}
