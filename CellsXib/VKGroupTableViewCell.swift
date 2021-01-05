//
//  VKGroupTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 27.12.2020.
//

import UIKit

class VKGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
