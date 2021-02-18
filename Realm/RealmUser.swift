//
//  RealmUser.swift
//  VKsimulator
//
//  Created by Admin on 17.02.2021.
//

import Foundation
import RealmSwift

class RealmUser: Object, ConvertToClear {

    @objc dynamic var id: Int = 0
    @objc dynamic var domain: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var sex: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var nickname: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var lastSeen: Int = 0
    @objc dynamic var birthdayDate: String = ""
    @objc dynamic var city: String = ""
 
    convenience init(id: Int, domain: String, firstName: String, lastName: String, sex: Int, photo50: String, photo100: String, photo200: String, online: Int, nickname: String, country: String, status: String, lastSeen: Int, birthdayDate: String, city: String) {
        self.init()
        self.id = id
        self.domain = domain
        self.firstName = firstName
        self.lastName = lastName
        self.sex = sex
        self.photo50 = photo50
        self.photo100 = photo100
        self.photo200 = photo200
        self.online = online
        self.nickname = nickname
        self.country = country
        self.status = status
        self.lastSeen = lastSeen
        self.birthdayDate = birthdayDate
        self.city = city
    }
}



extension RealmUser{
//    func convertToClear() -> VKUser.User{
//        return VKUser.User(id: self.id, domain: self.domain, firstName: self.firstName, lastName: self.lastName, sex: self.sex, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200, online: self.online, nickname: self.nickname, country: self.country, status: self.status, lastSeen: self.lastSeen, birthdayDate: self.birthdayDate, city: self.city)
//    }
    func convertToClear() -> Any {
        return VKUser.User(id: self.id, domain: self.domain, firstName: self.firstName, lastName: self.lastName, sex: self.sex, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200, online: self.online, nickname: self.nickname, country: self.country, status: self.status, lastSeen: self.lastSeen, birthdayDate: self.birthdayDate, city: self.city)
    }
}
