//
//  VKUserTableViewCell.swift
//  VKsimulator
//
//  Created by Admin on 21.01.2021.
//

import UIKit

final class VKUserTableViewCell: UITableViewCell {

    
    static let cellHeight: CGFloat = 60
    
    @IBOutlet weak var viewWithImage: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNicLable: UILabel!
    @IBOutlet weak var userDescrLabel: UILabel!
    @IBOutlet weak var userOnline: UIImageView!
    
    typealias ImageTapClosure = (() -> ())?
    var imageTapClosure: ImageTapClosure = nil
    
    static let reuseCellID = String(describing: VKUserTableViewCell.self)
    static let nib = UINib(nibName: reuseCellID, bundle: nil)
    
    
    
    func configur(user: VKUser, image: UIImage?, imageTapClosure: ImageTapClosure = nil){
        self.imageTapClosure = imageTapClosure
        userNicLable.text = user.nickname
        userDescrLabel.text = user.fio
        userOnline.tintColor = user.online == 1 ? UIColor.green : UIColor.gray
        userImageView.image = image
        userImageView.rounded()
        backgroundColor = UIColor.clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewWithImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped(_ sender: UIImage) {
        let bounds = self.userImageView.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.userImageView.bounds.size = CGSize(width: bounds.width + bounds.width / 4, height: bounds.height + bounds.height / 4)
        })
        self.imageTapClosure?()
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
