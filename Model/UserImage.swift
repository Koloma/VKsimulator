//
//  UserImage.swift
//  VKsimulator
//
//  Created by Admin on 04.01.2021.
//

import UIKit

struct UserImage{
    var image: UIImage
    var description: String = "Описание"
    var likeCount: Int = 3
    var isLikeSet: Bool = false
    
    init(image: UIImage) {
        self.image = image
    }
}
