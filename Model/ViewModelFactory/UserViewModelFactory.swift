//
//  UserViewModelFactory.swift
//  VKsimulator
//
//  Created by Alexander Kolomenskiy on 24.05.2021.
//

import UIKit

final class UserViewModelFactory{
    
    func constructViewModel(from users: [VKUser]) ->  [UserViewModel] {
        return users.compactMap(self.viewModel)
    }
    
    private func viewModel(from user: VKUser) -> UserViewModel{
        
        let userId = user.id
        
        let userImage = user.getImage(imageType: .image50)
        let fio = user.fio
        let descripton = "\(user.domain ?? "")"
        let onLineColor = user.online == 1 ? UIColor.green: UIColor.gray
        
        let time = Date.init(timeIntervalSince1970: user.lastSeen?.time ?? 0.0)
        let lastSeen = "Last seen: \(DateFormatter.ruFormat.string(from: time))"
        
        let city = user.city?.title ?? ""
        let birthdayDate = user.birthdayDate ?? "unspecified"
        let followersCount = ""
        let obrazovanie = ""
        
        return UserViewModel(userId: userId, userImage: userImage, fio: fio, descripton: descripton, onLineColor: onLineColor, lastSeen: lastSeen, city: city, birthdayDate: birthdayDate, obrazovanie: obrazovanie, followersCount: followersCount)
    }
}
