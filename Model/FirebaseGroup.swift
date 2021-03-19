//
//  FirebaseGroup.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 19.03.2021.
//

import Foundation
import FirebaseDatabase

class FirebaseGroup{
    
    let id: Int
    let name: String
    let screenName: String
    let isClosed: Int
    let photo: String
    
    let ref: DatabaseReference?
    
    init(id: Int, name: String, screenName: String, isClosed: Int, photo: String) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.photo = photo
        
        self.ref = nil
    }
    
    convenience init(from vkGroup: VKGroup) {
        let photo = vkGroup.photo50
        self.init(id: vkGroup.id, name: vkGroup.name, screenName: vkGroup.screenName, isClosed: vkGroup.isClosed, photo: photo)
    }
    
    init?(snapshot: DataSnapshot){
        guard let value = snapshot.value as? [String:Any] else { return nil }
        
        guard let id = value["id"] as? Int,
              let name = value["name"] as? String,
              let screenName = value["screenName"] as? String,
              let isClosed = value["isClosed"] as? Int,
              let photo = value["photo"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.photo = photo
        
        self.ref = snapshot.ref
    }
    
    init?(dict: [String: Any]){
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let screenName = dict["screenName"] as? String,
              let isClosed = dict["isClosed"] as? Int,
              let photo = dict["photo"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.photo = photo
        
        self.ref = nil
    }
    
    func toAnyObject()->[String: Any]{
        [
            "id": id,
            "name": name,
            "screenName": screenName,
            "isClosed": isClosed,
            "photo": photo
        ]
    }
}
