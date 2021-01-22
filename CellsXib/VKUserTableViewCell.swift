//
//  VKUserTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit

class VKUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNicLable: UILabel!
    @IBOutlet weak var userDescrLabel: UILabel!


    
    static let nib = UINib(nibName: "VKUserTableViewCell", bundle: nil)
    static let identifier = "CellUser"
    
    func configur(nicName: String, description: String?, userImage: UIImage?){
        userNicLable.text = nicName
        userDescrLabel.text = description
        userImageView.image = userImage
        userImageView.rounded()
        backgroundColor = UIColor.clear
        
    }
    
    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [K.Gradient.colorTop, K.Gradient.colorBottom]
        gradientLayer.locations = [0 as NSNumber, 1 as NSNumber]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
