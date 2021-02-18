//
//  RealmPhoto.swift
//  VKsimulator
//
//  Created by Admin on 17.02.2021.
//

import Foundation
import RealmSwift

class RealmPhoto:Object {
    @objc dynamic var isLikeSet: Bool = false
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var albumID: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var repostsCount: Int = 0
    @objc dynamic var realOffset: Int = 0
    @objc dynamic var imageUrlS75px: String = ""
    @objc dynamic var imageUrlM130px: String = ""
    @objc dynamic var imageUrlX604px: String = ""
    @objc dynamic var imageUrlZ1080: String = ""
    @objc dynamic var imageUrlW2560: String = ""
    
    struct Size {
        let height: Int
        let url: String
        let type: String
        let width: Int
    }
    
    convenience init(isLikeSet: Bool, likesCount: Int, albumID: Int, date: Int, id: Int, ownerID: Int, text: String, repostsCount: Int, realOffset: Int, imageUrlS75px: String, imageUrlM130px:String, imageUrlX604px:String, imageUrlZ1080:String, imageUrlW2560:String) {
        self.init()
        self.isLikeSet = isLikeSet
        self.likesCount = likesCount
        self.albumID = albumID
        self.date = date
        self.id = id
        self.ownerID = ownerID
        self.text = text
        self.repostsCount = repostsCount
        self.realOffset = realOffset
        self.imageUrlS75px = imageUrlS75px
        self.imageUrlM130px = imageUrlM130px
        self.imageUrlX604px = imageUrlX604px
        self.imageUrlZ1080 = imageUrlZ1080
        self.imageUrlW2560 = imageUrlW2560
    }
    
}

extension RealmPhoto{
    func convertToClear() -> VKPhoto.Photo{
        return VKPhoto.Photo(isLikeSet: self.isLikeSet, likesCount: self.likesCount, albumID: self.albumID, date: self.date, id: self.id, ownerID: self.ownerID, text: self.text, repostsCount: self.repostsCount, realOffset: self.realOffset, imageUrlS75px: self.imageUrlS75px, imageUrlM130px: self.imageUrlM130px, imageUrlX604px: self.imageUrlX604px, imageUrlZ1080: self.imageUrlZ1080, imageUrlW2560: self.imageUrlW2560)
    }
}
