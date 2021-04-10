//
//  VKGroupTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 27.12.2020.
//

import UIKit

final class VKGroupTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "VKGroupTableViewCell", bundle: nil)
    static let identifier = "CellGroup"
    static let height : CGFloat = 60
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLable: UILabel!
    
    func configur(group : VKGroup, image: UIImage?){
        groupNameLable.text = group.name
        groupImageView.image = image
        
        groupImageView.rounded()
    }
    
}
