//
//  VKGroupTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 27.12.2020.
//

import UIKit

class VKGroupTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "VKGroupTableViewCell", bundle: nil)
    static let identifier = "CellGroup"
    static let height : CGFloat = 60
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLable: UILabel!
    
    func configur(group : VKGroup){
        groupNameLable.text = group.name
        group.getImage(imageType: .image50){ image in
            DispatchQueue.main.async {
                self.groupImageView.image = image
            }
        }
        
        if let image = UIImage(named: "Group"){
            groupImageView.image = image
        }else{
            groupImageView.image = UIImage(systemName: "person.3")
        }
        
        groupImageView.rounded()
    }
    
}
