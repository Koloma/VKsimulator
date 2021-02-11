//
//  Session.swift
//  VKsimulator
//
//  Created by Admin on 07.02.2021.
//

import UIKit

class Session{
    
    static let shared = Session()
    
    var token: String = ""
    var userId: Int = Int()

   
    private init() {
    }
    
}

