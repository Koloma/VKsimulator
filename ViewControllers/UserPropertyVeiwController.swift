//
//  UserProperty.swift
//  VKsimulator
//
//  Created by Admin on 21.02.2021.
//

import UIKit

final class UserPropertyVeiwController: UIViewController{
    
    @IBOutlet weak var userImageVew: UIImageView!
    @IBOutlet weak var userFio: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var userOnLineStatus: UIImageView!
    @IBOutlet weak var lastSeenLable: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var obrazovaneLable: UILabel!
    @IBOutlet weak var followersCountLable: UILabel!
    
    
    var vkUser: VKUser?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUser(user: vkUser)
    }
    
    @IBAction func tapShowAllPhoto(_ sender: UIButton) {
        
        print(#function)
        guard let userId = vkUser?.id else { return }
        let controllerTable = AsyncPhotosConroller()
        controllerTable.userId = userId
        present(controllerTable, animated: true, completion: nil)
    }
    
    @IBAction func tapShowCollectionPhotos(_ sender: UIButton) {

        print(#function)
        guard let userId = vkUser?.id else { return }
        let controllerCollection = ASPhotosCollectionController(userId: userId)
        present(controllerCollection, animated: true, completion: nil)
    }
    
    private func setUser(user: VKUser?){
        guard let user = vkUser else { return }
        self.userImageVew.image =
            user.getImage(imageType: .image100){[weak self] image in
                DispatchQueue.main.async {
                    self?.userImageVew.image = image
                }
            }
        userFio.text = user.fio
        userDescription.text = "\(user.domain ?? "")"
        userOnLineStatus.tintColor = user.online == 1 ? UIColor.green: UIColor.gray
        

        let time = Date.init(timeIntervalSince1970: user.lastSeen?.time ?? 0.0)
        let lastSeen = DateFormatter.ruFormat.string(from: time)
        
        lastSeenLable.text = "Last seen: \(lastSeen)"
        
        cityLabel.text = user.city?.title ?? ""
        obrazovaneLable.text = user.birthdayDate
        //followersCountLable.text = "Followers \(user.followersCount)"
        
    }
    
}
