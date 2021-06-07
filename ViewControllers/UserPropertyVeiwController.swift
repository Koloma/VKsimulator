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
    
    
    var viewModel: UserViewModel!//{
//        didSet{
//            configure(with: viewModel)
//        }
//    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tapShowAllPhoto(_ sender: UIButton) {
        
        let controllerTable = AsyncPhotosConroller()
        controllerTable.userId = viewModel.userId
        present(controllerTable, animated: true, completion: nil)
    }
    
    @IBAction func tapShowCollectionPhotos(_ sender: UIButton) {

        let controllerCollection = ASPhotosCollectionController(userId: viewModel.userId)
        present(controllerCollection, animated: true, completion: nil)
    }
    
    func configure(with viewModel: UserViewModel) {
        self.viewModel = viewModel
        self.userImageVew.image = viewModel.userImage
        self.userFio.text = viewModel.fio
        self.userDescription.text = viewModel.descripton
        self.userOnLineStatus.tintColor = viewModel.onLineColor
        self.lastSeenLable.text = viewModel.lastSeen
        self.cityLabel.text = viewModel.city
        self.obrazovaneLable.text = viewModel.obrazovanie
        self.followersCountLable.text = viewModel.followersCount
    }
    
}
