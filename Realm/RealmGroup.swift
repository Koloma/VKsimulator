//
//  RealmGroup.swift
//  VKsimulator
//
//  Created by Admin on 17.02.2021.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
   
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""
    
    convenience init(id: Int, name: String, screenName: String, isClosed: Int, photo50: String, photo100: String, photo200: String) {
        self.init()
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.photo50 = photo50
        self.photo100 = photo100
        self.photo200 = photo200
    }
    
}

extension RealmGroup{
    func convertToClear() -> VKGroup.Group{
        return VKGroup.Group(id: self.id, name: self.name, screenName: self.screenName, isClosed: self.isClosed, photo50: self.photo50, photo100: self.photo100, photo200: self.photo200)
    }
}
    

