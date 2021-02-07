//
//  Session.swift
//  VKsimulator
//
//  Created by Admin on 07.02.2021.
//

import UIKit

class Session{
    
    static let shared = Session()
    
    struct Credential{
        var token: String
        var userId: Int
    }

    private var credential:Credential?
    
    private init() {
    }
    
    func setCredential(token: String, userId: Int){
        self.credential = Credential(token: token, userId: userId)
    }

    func setCredential(credential: Credential){
        self.credential = credential
    }
    
    func getCredential() -> Credential?{
        return credential
    }
}

