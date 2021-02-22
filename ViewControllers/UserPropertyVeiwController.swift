//
//  UserProperty.swift
//  VKsimulator
//
//  Created by Admin on 21.02.2021.
//

import UIKit

class UserPropertyVeiwController: UIViewController{
    
    @IBOutlet weak var userImageVew: UIImageView!
    @IBOutlet weak var userFio: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var userOnLineStatus: UIImageView!
    
    
    var vkUser: VKUser.User?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUser(user: vkUser)
    }
    
    private func setUser(user: VKUser.User?){
        guard let user = vkUser else { return }
        user.getImage(imageType: .image100){[weak self] image in
            DispatchQueue.main.async {
                self?.userImageVew.image = image
            }
        }
        userFio.text = "\(user.firstName) \(user.lastName)"
        userDescription.text = "\(user.domain) id:\(user.id)"
        userOnLineStatus.tintColor = user.online == 1 ? UIColor.green: UIColor.gray
        
    }
    
}
