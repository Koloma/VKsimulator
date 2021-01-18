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
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLable: UILabel!
    
    func configur(groupName: String){
        groupNameLable.text = groupName
        
        if let image = UIImage(named: "Group"){
            groupImageView.image = image
        }else{
            groupImageView.image = UIImage(systemName: "person.3")
        }
        
        groupImageView.rounded()
    }
    
}
